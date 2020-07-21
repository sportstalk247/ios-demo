//
//  RoomInhabitantsViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/12/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import Combine
import SportsTalk247
import MBProgressHUD
import Toast_Swift

class RoomParticipantsViewController: UITableViewController {
    var viewModel: RoomParticipantsViewModel!
}

// MARK: - Life Cycle
extension RoomParticipantsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchInhabitants()
    }
}

// MARK: - Convenience
extension RoomParticipantsViewController {
    private func setupView() {
        navigationItem.title = viewModel.title
        tableView.register(InhabitantsCell.nib, forCellReuseIdentifier: InhabitantsCell.identifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pulledToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupReactive() {
        viewModel
            .participants
            .receive(on: RunLoop.main)
            .sink { [unowned self] participants in
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel
            .isLoading
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] loading in
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
extension RoomParticipantsViewController {
    @objc private func pulledToRefresh() {
        viewModel.fetchInhabitants()
    }
}

// MARK: - Delegate Methods
extension RoomParticipantsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.participants.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InhabitantsCell.identifier, for: indexPath) as! InhabitantsCell

        if let user = viewModel.participants.value[indexPath.row].user {
            cell.configure(actor: Actor(from: user))
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let user = viewModel.participants.value[indexPath.row].user else { return nil }
        let actor = Actor(from: user)
        
        let banned = actor.banned
        let ban = UIContextualAction(style: .destructive, title: banned ? "Unban" : "Ban") { _, _, handler in
            DispatchQueue.main.async {
                if banned {
                    self.viewModel.unban(actor: actor)
                } else {
                    self.viewModel.ban(actor: actor)
                }
                handler(true)
            }
            handler(true)
        }
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { _, _, handler in
            DispatchQueue.main.async {
                self.viewModel.delete(actor: actor)
                handler(true)
            }
        }

        return UISwipeActionsConfiguration(actions: [ban, delete])
    }
}
