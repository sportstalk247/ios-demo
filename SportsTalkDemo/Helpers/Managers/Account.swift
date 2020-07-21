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

class Account {
    static let manager: Account = {
        let instance = Account()
        return instance
    }()

    var me: Actor?
    var eugene: Actor!
    var vincent: Actor!
    var dennis: Actor!
    var alfred: Actor!
    
    var admin: Actor!
}

// MARK: - Convenience
extension Account {
    func fetchUser(_ completion: ((_ success: Bool) -> Void)? = nil) {
        Session.manager.userClient.getUserDetails(Actors.Request.Me) { (code, _, _, user) in
            guard let user = user else {
                return
            }
            
            Account.manager.me = Actor(from: user)
            completion?(code == 200)
        }
    }
    
    func createAdmin() {
        let request = Actors.Request.Admin
        Session.manager.userClient.createOrUpdateUser(request) { [weak self] (code, _, _, user) in
            guard
                let self = self,
                let user = user
            else {
                return
            }
            
            self.admin = Actor(from: user)
        }
    }
    
    func createActors() {
        // Actor 1: Eugene
        let eugene = Actors.Request.Eugene
        Session.manager.userClient.createOrUpdateUser(eugene) { [weak self] (code, message, kind, user) in
            guard
                let self = self,
                let user = user
            else {
                return
            }
            
            self.eugene = Actor(from: user)
        }
        
        // Actor 2: Vincent
        let vincent = Actors.Request.Vincent
        Session.manager.userClient.createOrUpdateUser(vincent) { [weak self] (_, _, _, user) in
            guard
                let self = self,
                let user = user
            else {
                return
            }
            
            self.vincent = Actor(from: user)
        }
        
        // Actor 3: Dennis
        let dennis = Actors.Request.Dennis
        Session.manager.userClient.createOrUpdateUser(dennis) { [weak self] (_, _, _, user) in
            guard
                let self = self,
                let user = user
            else {
                return
            }
            
            self.dennis = Actor(from: user)
        }
        
        // Actor 4: Alfred
        let alfred = Actors.Request.Alfred
        Session.manager.userClient.createOrUpdateUser(alfred) { [weak self] (_, _, _, user) in
            guard
                let self = self,
                let user = user
            else {
                return
            }
            
            self.alfred = Actor(from: user)
        }
    }
    
    func locallyFetchActor(with userId: String) -> Actor? {
        // All actors in this test environment must be available locally.
        // In the event that you created an actor via website, you need to createUpdateUser
        // on this demo app and put him on this list.
        
        let actors = [
            Account.manager.me,
            Account.manager.eugene,
            Account.manager.vincent,
            Account.manager.dennis,
            Account.manager.alfred,
            Account.manager.admin
        ]
        
        return actors.filter{ $0?.userId == userId }.first ?? nil
    }
    
    func avatarForActor(_ sender: SenderType) -> Avatar? {
        guard let actor = sender as? Actor else {
            return nil
        }
        
        return actor.avatar
    }
}
