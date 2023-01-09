//
//  UserProfileViewMode.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/2/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import Combine
import SportsTalk247

class UserProfileViewModel {
    var cancellables = Set<AnyCancellable>()
    var submitEnabled = CurrentValueSubject<Bool, Never>(false)
    let isLoading  = PassthroughSubject<Bool, Never>()
    let errorMsg = PassthroughSubject<String, Never>()
    var isEditting: Bool = false
    
    // Required field: name, handle
    var name: String?       { didSet { shouldAllowSignup() } }
    var handle: String?     { didSet { shouldAllowSignup() } }
    var photoURL: URL?      { didSet { shouldAllowSignup() } }
    var profileURL: URL?    { didSet { shouldAllowSignup() } }
    
    var actor: Actor?
    
    init(actor: Actor? = nil) {
        self.actor = actor
    }
}

extension UserProfileViewModel {
    private func shouldAllowSignup() {
        if let handle = handle, !handle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            submitEnabled.send(true)
            return
        } else {
            if let name = name, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                submitEnabled.send(true)
                return
            }
        }
                
        submitEnabled.send(false)
    }
    
    func createUser(completion: @escaping (_ success: Bool) -> ()) {
        let request = UserRequest.CreateUpdateUser(
            // Setting userId is delegated to client so you can incorporate it to your own objects.
            userid: "demoappv001me",
            handle: handle?.trimmingCharacters(in: .whitespaces),
            displayname: name?.trimmingCharacters(in: .whitespaces),
            pictureurl: photoURL,
            profileurl: profileURL
        )
        
        isLoading.send(true)
        
        Session.manager.userClient.createOrUpdateUser(request) { (code, message, kind, user) in
            self.isLoading.send(false)
            
            if let message = message {
                self.errorMsg.send(message)
            }
            
            guard let user = user else {
                completion(false)
                return
            }
            
            Account.manager.me = Actor(from: user)
            completion(code == 200)
        }
    }
    
    func updateUser(completion: @escaping (_ success: Bool) -> ()) {
        guard let actor = actor else { return }
        
        let request = UserRequest.CreateUpdateUser(
            userid: actor.userId,
            displayname: name,
            pictureurl: photoURL,
            profileurl: profileURL
        )
        
        isLoading.send(true)
        
        Session.manager.userClient.createOrUpdateUser(request) { (code, message, kind, user) in
            self.isLoading.send(false)
            guard let user = user else {
                completion(false)
                return
            }
            
            if actor.userId == Account.manager.me?.userId {
                Account.manager.me = Actor(from: user)
            }
            
            completion(code == 200)
        }
    }
    
    func deleteUser(completion: @escaping (_ success: Bool) -> () ) {
        var currentActor: Actor
        if let actor = actor {
            currentActor = actor
        } else {
            guard let me = Account.manager.me else { return }
            currentActor = me
        }
        
        let request = UserRequest.DeleteUser(
            userid: currentActor.userId
        )

        isLoading.send(true)
        Session.manager.userClient.deleteUser(request) { (code, message, _, response) in
            if let message = message {
                self.errorMsg.send(message)
            }
            
            currentActor.deleteLocally()
            self.isLoading.send(false)
            completion(code == 200)
        }
    }
}
