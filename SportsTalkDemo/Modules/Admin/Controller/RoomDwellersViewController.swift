//
//  RoomInhabitantsViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/12/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit

class RoomInhabitantsViewController: UITableViewController {}

// MARK: - Life Cycle
extension RoomInhabitantsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // fetch
    }
}

// MARK: - Convenience
extension RoomInhabitantsViewController {
    private func setupView() {
        tableView.register(InhabitantsCell.nib, forCellReuseIdentifier: InhabitantsCell.identifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pulledToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupReactive() {}
}

// MARK: Actions & Events
extension RoomInhabitantsViewController {
    @objc private func pulledToRefresh() {
        print("pulled to refresh")
    }
}

// MARK: - Delegate Methods
extension RoomInhabitantsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InhabitantsCell.identifier, for: indexPath) as! InhabitantsCell

//        let room = viewModel.rooms.value[indexPath.row]
        
//        cell.configure(room: room)

        return cell
    }

}
