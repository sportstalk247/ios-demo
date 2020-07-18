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
    @IBOutlet var circularComponent: [UIView]!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var customIdField: UITextField!
    
    let viewModel = AddEditRoomViewModel()
    
}

// MARK: - Life Cycle
extension AddEditRoomViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        circularComponent.forEach {
            $0.layer.cornerRadius = $0.frame.height / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
}

// MARK: - Convenience
extension AddEditRoomViewController {
    private func setupView() {
        
    }
    
    private func setupReactive() {
        viewModel
            .message
            .receive(on: RunLoop.main)
            .sink { [unowned self] message in
                self.view.makeToast(message, duration: 0.5, position: .center)
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
        viewModel.description = descriptionField.text
        viewModel.customId = customIdField.text
        
        viewModel.createRoom(completion: { [unowned self] success in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                    self.dismiss(animated: true)
                }
            }
        })
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
