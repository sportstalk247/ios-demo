//
//  AddEditRoomViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/12/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import Combine
import SportsTalk247
import Toast_Swift
import MBProgressHUD

class AddEditRoomViewController: UIViewController {
    @IBOutlet weak var toolBarTitle: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var customIdField: UITextField!
    @IBOutlet weak var roomActionsSwitch: UISwitch!
    @IBOutlet weak var profanityFilterSwitch: UISwitch!
    @IBOutlet weak var enableEnterAndExitSwitch: UISwitch!
    @IBOutlet weak var openRoomSwitch: UISwitch!
    
    var viewModel: AddEditRoomViewModel!
}

// MARK: - Life Cycle
extension AddEditRoomViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
}

// MARK: - Convenience
extension AddEditRoomViewController {
    private func setupView() {
        toolBarTitle.title = "Create Room"
        
        if viewModel.selectedRoom != nil {
            toolBarTitle.title = "Edit Room"
            
            nameField.text = viewModel.name
            descriptionField.text = viewModel.summary
            customIdField.text = viewModel.customId
            roomActionsSwitch.isOn = viewModel.enableRoomActions
            profanityFilterSwitch.isOn = viewModel.enableProfanityFilter
            enableEnterAndExitSwitch.isOn = viewModel.enableEnterAndExit
            openRoomSwitch.isOn = viewModel.isOpen
            
            // Disable customId changes
            customIdField.isEnabled = false
        }
    }
    
    private func setupReactive() {
        viewModel
            .message
            .receive(on: RunLoop.main)
            .sink { [unowned self] message in
                self.view.makeToast(message, duration: 1.0, position: .center)
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
extension AddEditRoomViewController {
    @IBAction private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @IBAction private func submitButtonTapped() {
        viewModel.name = nameField.text
        viewModel.summary = descriptionField.text
        viewModel.customId = customIdField.text
        
        if viewModel.selectedRoom != nil {
            viewModel.editRoom { [unowned self] success in
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                        self.dismiss(animated: true)
                    }
                }
            }
        } else {
            viewModel.createRoom(completion: { [unowned self] success in
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                        self.dismiss(animated: true)
                    }
                }
            })
        }
    }
    
    @IBAction private func shoulEnableRoomActions(sender: UISwitch) {
        viewModel.enableRoomActions = sender.isOn
    }
    
    @IBAction private func shouldEnableProfanityFilter(sender: UISwitch) {
        viewModel.enableProfanityFilter = sender.isOn
    }
    
    @IBAction private func shouldEnableEnterAndExit(sender: UISwitch) {
        viewModel.enableEnterAndExit = sender.isOn
    }
    
    @IBAction private func shoulOpenRoom(sender: UISwitch) {
        viewModel.isOpen = sender.isOn
    }
}

// MARK: - Delegate Methods
extension AddEditRoomViewController {}

