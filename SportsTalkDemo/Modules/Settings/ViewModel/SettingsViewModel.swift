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
    var message = PassthroughSubject<String, Never>()
}

extension SettingsViewModel {
    func save(endpoint: String, id: String, token: String) {
        let endpoint = endpoint
        let appId = id
        let authToken = token
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
