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
        if let name = name, let handle = handle {
            submitEnabled.send(!name.isEmpty && !handle.isEmpty)
        } else {
            submitEnabled.send(false)
        }
    }
        
    func createUser(completion: @escaping (_ success: Bool) -> ()) {
        let request = UserRequest.CreateUpdateUser()
        // Setting userId is delegated to client so you can incorporate it to your own objects.
        request.userid = "demoapp.v.0.0.1.me"
        request.displayname = name
        request.handle = handle
        request.pictureurl = photoURL
        request.profileurl = profileURL
        
        isLoading.send(true)
        
        Session.manager.userClient.createOrUpdateUser(request) { (code, message, kind, user) in
            self.isLoading.send(false)
            guard let user = user else {
                completion(false)
                return
            }
            
            Account.manager.me = Actor(from: user)
            completion(code == 200)
        }
    }
    
    func deleteUser(completion: @escaping (_ success: Bool) -> () ) {
        guard let me = Account.manager.me else { return }
        let request = UserRequest.DeleteUser()
        request.userid = me.userId

        isLoading.send(true)
        Session.manager.userClient.deleteUser(request) { (code, _, _, response) in
            self.isLoading.send(false)
            completion(code == 200)
        }
    }
}
