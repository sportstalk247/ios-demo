//
//  SettingsTableViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 8/16/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet private weak var endpointField: UITextField!
    @IBOutlet private weak var appIdField: UITextField!
    @IBOutlet private weak var tokenField: UITextField!
    
    let viewModel = SettingsViewModel()
}

// MARK: - Life Cycle
extension SettingsTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
}

// MARK: - Convenience
extension SettingsTableViewController {
    private func setupView() {
        navigationItem.title = viewModel.title
        
        endpointField.text = Session.manager.endpoint
        endpointField.delegate = self
        
        appIdField.text = Session.manager.appId
        appIdField.delegate = self
        
        tokenField.text = Session.manager.authToken
        tokenField.delegate = self
        
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonTapped))
        navigationItem.rightBarButtonItem = done
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancel
    }
    
    private func setupReactive() {
        endpointField
            .textPublisher
            .debounce(for: .seconds(3), scheduler: RunLoop.main)
            .sink { text in
                guard let text = text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    self.viewModel.message.send("Default endpoint will be used\n(\(Session.manager.endpoint))")
                    return
                }
            }
            .store(in: &viewModel.cancellables)
        
        appIdField
            .textPublisher
            .debounce(for: .seconds(3), scheduler: RunLoop.main)
            .sink { text in
                guard let text = text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    self.viewModel.message.send("App Id is required")
                    return
                }
            }
            .store(in: &viewModel.cancellables)
        
        tokenField
            .textPublisher
            .debounce(for: .seconds(3), scheduler: RunLoop.main)
            .sink { text in
                guard let text = text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    self.viewModel.message.send("Auth Token is required")
                    return
                }
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.message
            .receive(on: RunLoop.main)
            .sink { message in
                self.view.makeToast(message, duration: 1.0, position: .center)
            }
            .store(in: &viewModel.cancellables)
    }
}

// MARK: Actions & Events
extension SettingsTableViewController {
    @objc private func doneButtonTapped() {
        view.endEditing(true)
        
        guard
            let appId = appIdField.text,
            !appId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let token = tokenField.text,
            !token.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            return
        }
        
        var endpoint: String
        
        if let text = endpointField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            endpoint = text
        }
        
        // Use default endpoint
        endpoint = "https://qa-talkapi.sportstalk247.com/api/v3/"
        
        viewModel.save(endpoint: endpoint, id: appId, token: token)
    }
    
    @objc private func cancelButtonTapped() {
        view.endEditing(true)
        endpointField.text = Session.manager.endpoint
        appIdField.text = Session.manager.appId
        tokenField.text = Session.manager.authToken
    }
}

// MARK: - Delegate Methods
// MARK: UITableView
extension SettingsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingsCell else {
            return
        }
        
        cell.textField.isEnabled = false
    }
}

// MARK: UITextField
extension SettingsTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
