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
    
    lazy var announcementView: UIAlertController = {
        let title = "Announcement"
        let message = "Make an Announcement"
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addTextField { textfield in
            textfield.placeholder = "Begin typing here"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            guard
                let self = self,
                let textfield = controller.textFields?.first,
                let text = textfield.text
            else {
                return
            }
            
            self.viewModel.makeAnnouncement(text)
        }
        
        controller.addAction(cancel)
        controller.addAction(confirm)
        
        return controller
    }()
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
        viewModel.selectedActor = nil
    }
}

// MARK: - Convenience
extension RoomParticipantsViewController {
    private func setupView() {
        navigationItem.title = viewModel.title
        tableView.register(ParticipantsCell.nib, forCellReuseIdentifier: ParticipantsCell.identifier)
        
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
        
        viewModel.systemMessage
            .receive(on: RunLoop.main)
            .sink { message in
                self.view.makeToast(message, duration: 1.0, position: .top)
            }
            .store(in: &viewModel.cancellables)
    }
}

// MARK: Actions & Events
extension RoomParticipantsViewController {
    @objc private func pulledToRefresh() {
        viewModel.fetchInhabitants()
    }
    
    @IBAction private func makeAnnouncement() {
        present(announcementView, animated: true)
    }
}

// MARK: - Navigation
extension RoomParticipantsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.User.presentUserProfile {
            if let destination = segue.destination as? UserProfileTableViewController {
                guard let actor = viewModel.selectedActor else { return }
                destination.viewModel = UserProfileViewModel(actor: actor)
            }
        }
    }
}


// MARK: - Delegate Methods
// MARK: UITableViewDelegate
extension RoomParticipantsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.participants.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ParticipantsCell.identifier, for: indexPath) as! ParticipantsCell

        if let user = viewModel.participants.value[indexPath.row].user {
            cell.configure(actor: Actor(from: user))
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let user = viewModel.participants.value[indexPath.row].user {
            viewModel.selectedActor = Actor(from: user)
            performSegue(withIdentifier: Segue.Admin.presentUserProfile, sender: self)
        }
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
