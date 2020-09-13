//
//  SettingsCell.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 7/5/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    static let identifier = "SettingsCell"
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var data: SettingsCellData!
}

extension SettingsCell {
    func configure(model: SettingsCellData) {
        data = model
        title.text = model.title
        textField.text = model.value
        textField.delegate = self
    }
}

extension SettingsCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
