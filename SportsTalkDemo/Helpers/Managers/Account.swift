//
//  AccountManager.swift
//  SportsTalkDemo
//
//  In order to simplify persistent storage, we will just create a singleton that will hold
//  accounts
//
//  Created by Angelo Lesano on 5/30/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import SportsTalk247
import MessageKit
import Combine  

class Account {
    static let manager: Account = {
        let instance = Account()
        return instance
    }()

    @Published var me: Actor?
    var actors = [Actor]()          /*{ didSet { print("Actors++\n \(actors.map { $0.handle } )") } }*/
    var systemActors = [Actor]()    /*{ didSet { print("SystemActors++\n\(systemActors.map { $0.handle })" ) } }*/
}

// MARK: - Convenience
extension Account {
    func fetchUser(_ completion: ((_ success: Bool) -> Void)? = nil) {
        Session.manager.userClient.getUserDetails(Actors.Create.Request.Me) { (code, _, _, user) in
            if let user = user {
                let me  = Actor(from: user)
                Account.manager.me = me
                if !self.actors.contains(me) {
                    self.actors.append(me)
                }
            }
            
            completion?(code == 200)
        }
    }
    
    func fetchUpdateSystemUsers() {
        let searchRequests = [
            Actors.Search.Request.Eugene,
            Actors.Search.Request.Vincent,
            Actors.Search.Request.Alfred,
            Actors.Search.Request.Vincent,
            Actors.Search.Request.Admin
        ]
        
        searchRequests.forEach { request in
            Session.manager.userClient.searchUser(request) { [weak self] (code, message, kind, list) in
                guard let self = self else { return }
                guard let users = list?.users else { return }
                
                for user in users {
                    let actor = Actor(from: user)
                    if !self.systemActors.contains(actor) {
                        self.systemActors.append(actor)
                    }
                }
            }
        }
        
        if systemActors.isEmpty {
            let createRequests = [
                Actors.Create.Request.Eugene,
                Actors.Create.Request.Vincent,
                Actors.Create.Request.Alfred,
                Actors.Create.Request.Vincent,
                Actors.Create.Request.Admin
            ]
            
            createRequests.forEach { request in
                Session.manager.userClient.createOrUpdateUser(request) { [weak self] (code, message, kind, user) in
                    guard let self = self else { return }
                    guard let user = user else { return }
                    let actor = Actor(from: user)
                    if !self.systemActors.contains(actor) {
                        self.systemActors.append(actor)
                    }
                }
            }
        }
    }
        
    func avatarForActor(_ sender: SenderType) -> Avatar? {
        guard let actor = sender as? Actor else {
            return nil
        }
        
        return actor.avatar
    }
}
