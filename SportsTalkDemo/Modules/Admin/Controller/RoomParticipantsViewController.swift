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
        viewModel.selectedActor = nil
        viewModel.fetchParticipants()
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
        
        viewModel.message
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
        viewModel.fetchParticipants()
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
                destination.delegate = self
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
            let actor = Actor(from: user)
            viewModel.selectedActor = actor
            
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let purge = UIAlertAction(title: "Purge", style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.purge(actor: actor)
            }
            sheet.addAction(purge)
            
            let deleteAllMsgs = UIAlertAction(title: "Delete All Messages", style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.deleteAll(actor: actor)
            }
            sheet.addAction(deleteAllMsgs)
            
            let ban = UIAlertAction(title: "Ban / Unban", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if actor.banned {
                    self.viewModel.unban(actor: actor)
                } else {
                    self.viewModel.ban(actor: actor)
                }
            }
            sheet.addAction(ban)
            
            if let bouncedusers = viewModel.room.bouncedusers,
               bouncedusers.contains(actor.handle) {
                let unbounce = UIAlertAction(title: "Unbounce", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.bounce(false, actor: actor)
                }
                sheet.addAction(unbounce)
            } else {
                let bounce = UIAlertAction(title: "Bounce", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.bounce(true, actor: actor)
                }
                sheet.addAction(bounce)
            }
            
            if !Account.manager.systemActors.map({ $0.userId }).contains(where: { $0 == actor.userId }) {
                let edit = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    self.performSegue(withIdentifier: Segue.Admin.presentUserProfile, sender: self)
                }
                sheet.addAction(edit)
                
                let deleteAcct = UIAlertAction(title: "Delete Account", style: .destructive) { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.delete(actor: actor)
                }
                sheet.addAction(deleteAcct)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            sheet.addAction(cancel)
            present(sheet, animated: true, completion: nil)
        }
    }
}

extension RoomParticipantsViewController: UserProfileDelegate {
    func didDismiss() {
        viewModel.fetchParticipants()
    }
}
