//
//  AdminRoomListViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/12/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import Combine
import SportsTalk247
import MBProgressHUD

class AdminRoomsViewController: UITableViewController {
    let viewModel = AdminRoomsViewModel()
}

// MARK: - Life Cycle
extension AdminRoomsViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchRooms()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
}

// MARK: - Convenience
extension AdminRoomsViewController {
    private func setupView() {    
        navigationItem.title = viewModel.title
        
        tableView.register(AdminRoomCell.nib, forCellReuseIdentifier: AdminRoomCell.identifier)
        
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
            .isLoading
            .receive(on: RunLoop.main)
            .sink { loading in
                if loading {
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            .store(in: &viewModel.cancellables)
    }
}

// MARK: Actions & Events
extension AdminRoomsViewController {
    @objc private func pulledToRefresh() {
        viewModel.fetchRooms()
    }
    
    @IBAction private func addRoom() {
        viewModel.selectedRoom = nil
        performSegue(withIdentifier: Segue.Admin.presentAddRoom, sender: self)
    }
}

// MARK: - Delegate Methods
// MARK: UITableView
extension AdminRoomsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rooms.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminRoomCell.identifier, for: indexPath) as! AdminRoomCell
        
        cell.delegate = self

        let room = viewModel.rooms.value[indexPath.row]
        
        cell.configure(room: room)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedRoom = viewModel.rooms.value[indexPath.row]
        performSegue(withIdentifier: Segue.Admin.showInhabitants, sender: self)
    }
}

// MARK: AdminRoomCell
extension AdminRoomsViewController: AdminRoomCellDelegate {
    func delete(cell: AdminRoomCell, room: ChatRoom) {
        viewModel.deleteRoom(room: room) { [weak self] success in
            guard let self = self else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self.viewModel.fetchRooms()
            }
        }
    }
    
    func edit(cell: AdminRoomCell, room: ChatRoom) {
        viewModel.selectedRoom = room
        performSegue(withIdentifier: Segue.Admin.presentAddRoom, sender: self)
    }
}

// MARK: - Navigation
extension AdminRoomsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.Admin.presentAddRoom {
            if let destination = segue.destination as? AddEditRoomViewController {
                destination.viewModel = AddEditRoomViewModel(room: viewModel.selectedRoom)
            }
        } else if segue.identifier == Segue.Admin.showInhabitants {
            if let destination = segue.destination as? RoomParticipantsViewController {
                guard let room = viewModel.selectedRoom else {
                    return
                }
                
                destination.viewModel = RoomParticipantsViewModel(room: room)
            }
        }
    }
}
