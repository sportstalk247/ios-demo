//
//  SettingsViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 7/3/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let viewModel = SettingsViewModel()
    
    var activeIndexPath: IndexPath?
}

// MARK: - Life Cycle
extension SettingsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
}

// MARK: - Convenience
extension SettingsViewController {
    private func setupView() {
        navigationItem.title = viewModel.title
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonTapped))
        navigationItem.rightBarButtonItem = done
    }
    
    private func setupReactive() {    }
}

// MARK: Actions & Events
extension SettingsViewController {}

// MARK: - Delegate Methods
// MARK: UITableView
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier) as? SettingsCell else {
            return UITableViewCell()
        }
        
        cell.configure(model: viewModel.datasource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingsCell else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        activeIndexPath = indexPath
        cell.textField.isEnabled = true
        cell.textField.becomeFirstResponder()
        
        cell.textField
            .textPublisher
            .receive(on: RunLoop.main)
            .sink { text in
                guard let indexPath = self.activeIndexPath else { return }
                guard let text = text else { return }
                
                self.viewModel.datasource[indexPath.row].value = text
                print(self.viewModel.datasource[indexPath.row].value)
            }
            .store(in: &viewModel.cancellables)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingsCell else {
            return
        }
        
        cell.textField.isEnabled = false
    }
}

// MARK: Actions & Events
extension SettingsViewController {
    @objc private func doneButtonTapped() {
        viewModel.save()
    }
}
