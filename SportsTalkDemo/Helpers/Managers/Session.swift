//
//  SessionManager.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 7/3/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import SportsTalk247

fileprivate let keyEndpoint = "key.endpoint"
fileprivate let keyAppId = "key.appId"
fileprivate let keyAuthToken = "key.authToken"


class Session {
    static let manager: Session = {
        let instance = Session()
        return instance
    }()
    
    let defaults = UserDefaults.standard
    
    #warning("WARNING: Limited Access")
    /* ----------------------- */
    /* WARNING: Limited Access */
    /* ----------------------- */
    // You are using a demo SportsTalk App that you cannot access from Dashboard.
    // To gain full control over this demo app, please create an account on https://qa-dashboard.sportstalk247.com
    // and replace these values
    var endpoint = "https://qa-talkapi.sportstalk247.com/api/v3/"
    var appId: String = "5f2406775617e0238cdbb882"
    var authToken: String = "ZfVuKrL-yEK3tXMkJWpnAQN9LLMb-_qEm885JCPGr_kg"
    
    private var clientConfig: ClientConfig! {
        didSet { updateClients() }
    }
    
    lazy var userClient: UserClient = {
        return UserClient(config: clientConfig)
    }()
    
    lazy var chatClient: ChatClient = {
        return ChatClient(config: clientConfig)
    }()
}

extension Session {
    func configure(endpoint: String? = nil, identifier: String, token: String) {
        if let endpoint = endpoint {
            self.endpoint = endpoint
        }
    
        self.appId = identifier
        self.authToken = token
        
        defaults.setValue(endpoint, forKey: keyEndpoint)
        defaults.setValue(appId, forKey: keyAppId)
        defaults.setValue(authToken, forKey: keyAuthToken)
        
        let url = URL(string: self.endpoint)!
        self.clientConfig = ClientConfig(appId: self.appId, authToken: self.authToken, endpoint: url)
    }
    
    func fetchConfig() {
        guard
            let endpoint = defaults.string(forKey: keyEndpoint),
            let appId = defaults.string(forKey: keyAppId),
            let authToken = defaults.string(forKey: keyAuthToken)
        else {
            let url = URL(string: self.endpoint)!
            self.clientConfig = ClientConfig(appId: self.appId, authToken: self.authToken, endpoint: url)
            return
        }
        
        self.endpoint = endpoint
        self.appId = appId
        self.authToken = authToken
        
        let url = URL(string: endpoint)
        self.clientConfig = ClientConfig(appId: self.appId, authToken: self.authToken, endpoint: url)
    }
    
    func clearSession() {
        UserDefaults.standard.removeObject(forKey: keyAuthToken)
        UserDefaults.standard.removeObject(forKey: keyAppId)
        UserDefaults.standard.removeObject(forKey: keyAuthToken)
    }
    
    private func updateClients() {
        userClient = UserClient(config: clientConfig)
        chatClient = ChatClient(config: clientConfig)
    }
}

// MARK: Debug
extension Session {
    func check() {
        print(endpoint)
        print(appId)
        print(authToken)
    }
}
