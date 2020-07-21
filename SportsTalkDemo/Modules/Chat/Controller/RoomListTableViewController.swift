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

class RoomListViewController: UITableViewController {
    
    let viewModel = RoomListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
}

// MARK: - Convenience
extension RoomListViewController {
    private func setupView() {
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
    }
        
    private func joinRoom(with room: ChatRoom) {
        if let controller = Storyboard.user.instantiateViewController(identifier: "RoomViewController") as? RoomViewController {
            controller.viewModel = RoomViewModel(room: room)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: Actions & Events
extension RoomListViewController {
    @objc private func pulledToRefresh() {
        viewModel.fetchRooms()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomCell

        let room = viewModel.rooms.value[indexPath.row]
        
        cell.configure(room: room)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        func joinRoom() {
            let room = viewModel.rooms.value[indexPath.row]
            
            guard let roomId = room.id else {
                return
            }
            
            viewModel.joinRoom(roomId: roomId)
        }
        
        if AccountManager.shared.me == nil {
            AccountManager.shared.fetchUser { success in
                if success {
                    joinRoom()
                } else {
                    self.performSegue(withIdentifier: Segue.Chat.showUserProfile, sender: self)
                }
            }
        } else {
            joinRoom()
        }
    }
}
