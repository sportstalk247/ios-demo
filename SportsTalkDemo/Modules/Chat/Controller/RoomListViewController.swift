//
//  RoomListTableViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 5/26/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import Combine
import SportsTalk247
import MBProgressHUD

class RoomListViewController: UITableViewController {
    let viewModel = RoomListViewModel()
}

// MARK: - Life Cycle
extension RoomListViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchRooms()
        tableView.allowsSelection = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
}

// MARK: - Convenience
extension RoomListViewController {
    private func setupView() {
        navigationItem.title = viewModel.title
        
        tableView.register(RoomCell.nib, forCellReuseIdentifier: RoomCell.identifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pulledToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupReactive() {
        viewModel
            .rooms
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
        }
        .store(in: &viewModel.cancellables)
        
        viewModel
            .selectedRoom
            .receive(on: RunLoop.main)
            .sink { [unowned self] room in
                self.joinRoom(with: room)
            }
            .store(in: &viewModel.cancellables)
        
        viewModel
            .isLoading
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] loading in
                if loading {
                    self.tableView.refreshControl?.endRefreshing()
                } else {
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.systemMessage
            .receive(on: RunLoop.main)
            .sink { [unowned self] message in
                self.view.makeToast(message, duration: 1.0, position: .center)
            }
            .store(in: &viewModel.cancellables)
    }
}

// MARK: Actions & Events
extension RoomListViewController {
    @objc private func pulledToRefresh() {
        viewModel.fetchRooms()
    }
    
    private func joinRoom(with room: ChatRoom) {
        if let controller = Storyboard.User.instantiateViewController(identifier: "RoomViewController") as? RoomViewController {
            controller.viewModel = RoomViewModel(room: room)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - Delegate
// MARK: UITableView
extension RoomListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rooms.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomCell.identifier, for: indexPath) as! RoomCell

        let room = viewModel.rooms.value[indexPath.row]
        
        cell.configure(room: room)
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: RoomCellDelegate
extension RoomListViewController: RoomCellDelegate {
    func didTapJoin(cell: RoomCell) {
        if Account.manager.me == nil {
            Account.manager.fetchUser { success in
                if success {
                    guard let roomId = cell.room.id else {
                        return
                    }
                    
                    self.viewModel.joinRoom(roomId: roomId)
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: Segue.User.presentUserProfile, sender: self)
                    }
                }
            }
        } else {
            guard let roomId = cell.room.id else {
                return
            }

            self.viewModel.joinRoom(roomId: roomId)
        }
    }
}

// MARK: - Navigation
extension RoomListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.User.presentUserProfile {
            if let destination = segue.destination as? UserProfileTableViewController {
                destination.viewModel = UserProfileViewModel(actor: nil)
            }
        }
    }
}
