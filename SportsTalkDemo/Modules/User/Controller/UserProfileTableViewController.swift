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
import MBProgressHUD
import Toast_Swift

protocol UserProfileDelegate: class {
    func didDismiss()
}

class UserProfileTableViewController: UITableViewController {
    
    @IBOutlet var circularComponents: [UIView]!
    @IBOutlet var borderedComponents: [UIView]!
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var handleField: UITextField!
    @IBOutlet weak var photoField: UITextField!
    @IBOutlet weak var profileField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    weak var delegate: UserProfileDelegate?
    
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
            nameField.text = actor.name
            viewModel.name = actor.name
            
            handleField.text = actor.handle
            handleField.isEnabled = false
            viewModel.handle = actor.handle
            
            photoField.text = actor.photoURL?.absoluteString
            viewModel.photoURL = actor.photoURL
            
            profileField.text = actor.profileURL?.absoluteString
            viewModel.profileURL = actor.profileURL
            
            if let photoURL = actor.photoURL {
                photoView.sd_setImage(with: photoURL, placeholderImage: UIImage(systemName: "person.fill"), completed: nil)
            }
            
            submitButton.setTitle("Delete Account", for: .normal)
        } else {
            handleField.isEnabled = true
            submitButton.setTitle("Submit", for: .normal)
        }
        
        nameField.delegate = self
        handleField.delegate = self
        photoField.delegate = self
        profileField.delegate = self
    }
    
    private func setupReactive() {
        nameField
            .textPublisher
            .throttle(for: .milliseconds(400), scheduler: RunLoop.main, latest: true)
            .sink { [unowned self] text in
                self.viewModel.name = text
                
                guard let actor = self.viewModel.actor else {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Submit", for: .normal)
                    return
                }
                
                if actor.name != text {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Edit Account", for: .normal)
                } else {
                    self.viewModel.isEditting = false
                    self.submitButton.setTitle("Delete Account", for: .normal)
                }
            }
            .store(in: &viewModel.cancellables)
        
        handleField
            .textPublisher
            .throttle(for: .milliseconds(400), scheduler: RunLoop.main, latest: true)
            .sink { [unowned self] text in
                self.viewModel.handle = text
                
                guard let actor = self.viewModel.actor else {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Submit", for: .normal)
                    return
                }
                
                if actor.handle != text {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Edit Account", for: .normal)
                } else {
                    self.viewModel.isEditting = false
                    self.submitButton.setTitle("Delete Account", for: .normal)
                }
            }
            .store(in: &viewModel.cancellables)
        
        photoField
            .textPublisher
            .throttle(for: .milliseconds(400), scheduler: RunLoop.main, latest: true)
            .removeDuplicates()
            .sink { [unowned self] text in
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

                
                guard let actor = self.viewModel.actor else {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Submit", for: .normal)
                    return
                }
                
                if actor.photoURL != URL(string: text) {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Edit Account", for: .normal)
                } else {
                    self.viewModel.isEditting = false
                    self.submitButton.setTitle("Delete Account", for: .normal)
                }
            }
            .store(in: &viewModel.cancellables)
        
        profileField
            .textPublisher
            .throttle(for: .milliseconds(400), scheduler: RunLoop.main, latest: true)
            .sink { [unowned self] text in
                guard
                    let text = text,
                    let url = URL(string: text)
                else {
                    self.viewModel.photoURL = nil
                    self.photoView.image = UIImage(systemName: "person.fill")
                    return
                }
                                
                self.viewModel.profileURL = url
                
                guard let actor = self.viewModel.actor else {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Submit", for: .normal)
                    return
                }
                
                if actor.profileURL != URL(string: text) {
                    self.viewModel.isEditting = true
                    self.submitButton.setTitle("Edit Account", for: .normal)
                } else {
                    self.viewModel.isEditting = false
                    self.submitButton.setTitle("Delete Account", for: .normal)
                }
            }
            .store(in: &viewModel.cancellables)
        
        viewModel
            .submitEnabled
            .assign(to: \.isEnabled, on: submitButton)
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
        
        viewModel
            .errorMsg
            .receive(on: RunLoop.main)
            .sink { message in
                self.view.makeToast(message, duration: 3.0, position: .center)
            }
            .store(in: &viewModel.cancellables)
    }
    
    func safelyDismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.delegate?.didDismiss()
            }
        }
    }
}

// MARK: Actions & Events
extension UserProfileTableViewController {
    @IBAction private func submitButtonTapped() {
        if viewModel.actor == nil {
            viewModel.createUser { completed in
                if completed {
                     self.safelyDismiss()
                }
            }
        } else {
            if self.viewModel.isEditting {
                viewModel.updateUser { completed in
                    if completed {
                         self.safelyDismiss()
                    }
                }
            } else {
                viewModel.deleteUser { completed in
                    if completed {
                         self.safelyDismiss()
                    }
                }
            }
        }
    }
    
    @IBAction private func cancelButtonTapped() {
        safelyDismiss()
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

// MARK: UITextField
extension UserProfileTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:     handleField.becomeFirstResponder()
        case handleField:   photoField.becomeFirstResponder()
        case photoField:    profileField.becomeFirstResponder()
        case profileField:  textField.resignFirstResponder()
        default:            textField.resignFirstResponder()
        }

        return true
    }
}
