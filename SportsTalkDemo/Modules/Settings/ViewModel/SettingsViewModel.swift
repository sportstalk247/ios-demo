//
//  SettingsViewModel.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 7/3/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import Combine

class SettingsViewModel {
    
    let title = "Settings"
    
    var cancellables = Set<AnyCancellable>()
    
    var datasource = [
        SettingsCellData(title: "Endpoint", value: Session.manager.endpoint),
        SettingsCellData(title: "App Id", value: Session.manager.appId),
        SettingsCellData(title: "AuthToken", value: Session.manager.authToken),
    ]
}

extension SettingsViewModel {
    func save() {
        print(datasource)
        let endpoint = datasource[0].value
        let appId = datasource[1].value
        let authToken = datasource[2].value
        Session.manager.configure(endpoint: endpoint, identifier: appId, token: authToken)
        Session.manager.check()
    }
}

struct SettingsCellData {
    var title: String
    var value: String
    var placeholder: String?
    var canBecomeFirstResponder: Bool
    
    init(title: String, value: String? = nil, placeholder: String? = nil, canBecomeFirstResponder: Bool = true) {
        self.title = title
        self.value = value == nil ? "" : value!
        self.placeholder = placeholder
        self.canBecomeFirstResponder = canBecomeFirstResponder
    }
}
