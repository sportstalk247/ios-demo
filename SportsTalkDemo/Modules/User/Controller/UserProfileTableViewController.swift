//
//  UserProfileTableViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 5/30/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import Combine
import SDWebImage

class UserProfileTableViewController: UITableViewController {
    
    @IBOutlet var circularComponents: [UIView]!
    @IBOutlet var borderedComponents: [UIView]!
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var handleField: UITextField!
    @IBOutlet weak var photoField: UITextField!
    @IBOutlet weak var profileField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var viewModel: UserProfileViewModel!
}

extension UserProfileTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circularComponents.forEach { $0.layer.cornerRadius = $0.frame.height / 2 }
        
        borderedComponents.forEach {
            $0.layer.borderColor = UIColor.darkGray.cgColor
            $0.layer.borderWidth = 1
        }
    }
}

// MARK: - Convenience Methods
extension UserProfileTableViewController {
    private func setupView() {
        if let actor = viewModel.actor {
            if let photoURL = actor.photoURL {
                self.photoView.sd_setImage(with: photoURL, placeholderImage: UIImage(systemName: "person.fill"), completed: nil)
            }
            
            self.nameField.text = actor.displayName
            viewModel.name = actor.displayName
            
            self.handleField.text = actor.handle
            viewModel.handle = actor.handle
            
            self.photoField.text = actor.photoURL?.absoluteString
            viewModel.photoURL = actor.photoURL
            
            self.profileField.text = actor.profileURL?.absoluteString
            viewModel.profileURL = actor.profileURL
            
            self.submitButton.setTitle("Delete Account", for: .normal)
        } else {
            self.submitButton.setTitle("Submit", for: .normal)
        }
    }
    
    private func setupReactive() {
        nameField
            .textPublisher
            .throttle(for: .milliseconds(400), scheduler: RunLoop.main, latest: true)
            .sink { [unowned self] text in
                let name = self.viewModel.actor?.name
                if name != text {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Edit Account", for: .normal)
                } else {
                    self.viewModel.isEditting = false
                    self.submitButton.setTitle("Delete Account", for: .normal)
                }
                
                self.viewModel.name = text
            }
            .store(in: &viewModel.cancellables)
        
        handleField
            .textPublisher
            .throttle(for: .milliseconds(400), scheduler: RunLoop.main, latest: true)
            .sink { [unowned self] text in
                let handle = self.viewModel.actor?.handle
                if handle != text {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Edit Account", for: .normal)
                } else {
                    self.viewModel.isEditting = false
                    self.submitButton.setTitle("Delete Account", for: .normal)
                }
                
                self.viewModel.handle = text
            }
            .store(in: &viewModel.cancellables)
        
        photoField
            .textPublisher
            .throttle(for: .milliseconds(400), scheduler: RunLoop.main, latest: true)
            .removeDuplicates()
            .sink { [unowned self] text in
                let photoURL = self.viewModel.actor?.photoURL
                if photoURL != URL(string: text ?? "") {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Edit Account", for: .normal)
                } else {
                    self.viewModel.isEditting = false
                    self.submitButton.setTitle("Delete Account", for: .normal)
                }

                guard
                    let text = text,
                    let url = URL(string: text)
                else {
                    self.viewModel.photoURL = nil
                    self.photoView.image = UIImage(systemName: "person.fill")
                    return
                }
                
                self.viewModel.photoURL = url
                self.photoView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.fill"), completed: nil)
            }
            .store(in: &viewModel.cancellables)
        
        profileField
            .textPublisher
            .throttle(for: .milliseconds(400), scheduler: RunLoop.main, latest: true)
            .sink { [unowned self] text in
                let profileURL = self.viewModel.actor?.profileURL
                if profileURL != URL(string: text ?? "") {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Edit Account", for: .normal)
                } else {
                    self.viewModel.isEditting = false
                    self.submitButton.setTitle("Delete Account", for: .normal)
                }
                
                guard
                    let text = text,
                    let url = URL(string: text)
                else {
                    self.viewModel.profileURL = nil
                    return
                }
                
                self.viewModel.profileURL = url

            }
            .store(in: &viewModel.cancellables)
        
        viewModel
            .submitEnabled
            .assign(to: \.isEnabled, on: submitButton)
            .store(in: &viewModel.cancellables)
    }
}

// MARK: Actions & Events
extension UserProfileTableViewController {
    @IBAction private func submitButtonTapped() {
        if viewModel.actor == nil {
            viewModel.createUser { success in
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            if viewModel.actor! == Account.manager.me {
                if viewModel.isEditting {
                    viewModel.createUser { _ in self.dismiss(animated: true) }
                } else {
                    viewModel.deleteUser { _ in self.dismiss(animated: true) }
                }
            } else {
                self.submitButton.isHidden = true
            }
        }
    }
}

// MARK: - Delegate Methods
// MARK: UITableView
extension UserProfileTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
