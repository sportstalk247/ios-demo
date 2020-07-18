//
//  Actor.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/6/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import SportsTalk247
import MessageKit
import SDWebImage

class Actor: SenderType {
    var userId: String
    var name: String
    var handle: String
    var banned: Bool
    var photoURL: URL?
    var profileURL: URL?
    var avatar: Avatar?
    var original: User
    
    var senderId: String {
        return userId
    }
    
    var displayName: String {
        return handle
    }
    
    init(from user: User) {
        guard
            let userId = user.userid,
            let name = user.displayname
        else {
            fatalError("Invalid user: missing userid")
        }
        
        self.original = user
        self.userId = userId
        self.name = name
        
        if let photoString = user.pictureurl {
            self.photoURL = URL(string: photoString)
        }
        
        if let profileString = user.profileurl {
            self.profileURL = URL(string: profileString)
        }
        
        if user.handle == nil {
            self.handle = ("@" + name.trimmingCharacters(in: .whitespaces)).lowercased()
        } else {
            self.handle = user.handle!
        }
        
        self.banned = user.banned ?? false
        
        if let pictureURL = user.pictureurl {
            SDWebImageDownloader().downloadImage(with: URL(string: pictureURL)) { (image, _, _, _) in
                guard let image = image else { return }
                self.avatar = Avatar(image: image, initials: self.handle)
            }
        }
    }
}

extension Actor: Equatable {
    static func ==(lhs: Actor, rhs: Actor) -> Bool {
        return lhs.userId == rhs.userId
    }
}

struct Actors {
    struct Request {
        static let Me: UserRequest.GetUserDetails = {
            let request = UserRequest.GetUserDetails()
            request.userid = "demoapp.v.0.0.1.me"
            return request
        }()
        
        static let Eugene: UserRequest.CreateUpdateUser = {
           let request = UserRequest.CreateUpdateUser()
            request.userid = "demoapp.v.0.0.1.eugene"
            request.displayname = "Eugene"
            request.handle = "youj"
            request.pictureurl =
                URL(string: "https://media.istockphoto.com/photos/portrait-of-chinese-young-mustached-man-looking-at-camera-with-gray-picture-id1158112527?k=6&m=1158112527&s=612x612&w=0&h=6tXjyyZ_rdS7s0D6gfcr840kPeR4aUkZuAQCXvlRRTs=")
            return request
        }()
        
        static let Vincent: UserRequest.CreateUpdateUser = {
           let request = UserRequest.CreateUpdateUser()
            request.userid = "demoapp.v.0.0.1.vincent"
            request.displayname = "Vincent"
            request.handle = "centine"
            request.pictureurl =
                URL(string: "https://media.istockphoto.com/photos/upper-body-of-young-men-picture-id1082006126?k=6&m=1082006126&s=612x612&w=0&h=cXUiPDBXt09VhKYNc4IU8jxSIOuzL7u70ZLfhmh3Uos=")
            return request
        }()
        
        static let Dennis: UserRequest.CreateUpdateUser = {
            let request = UserRequest.CreateUpdateUser()
            request.userid = "demoapp.v.0.0.1.dennis"
            request.displayname = "Dennis"
            request.handle = "yourhomeboydennis"
            request.pictureurl =
                URL(string: "https://st.depositphotos.com/1771835/1478/i/450/depositphotos_14781729-stock-photo-happy-asian-doctor-folded-arms.jpg")
            return request
        }()
        
        static let Alfred: UserRequest.CreateUpdateUser = {
            let request = UserRequest.CreateUpdateUser()
            request.userid = "demoapp.v.0.0.1.alfred"
            request.displayname = "Alfred"
            request.handle = "batmanhu"
            request.pictureurl =
                URL(string: "https://st2.depositphotos.com/1550494/7408/i/450/depositphotos_74089543-stock-photo-male-butler-wearing-formal-tuxedo.jpg")
            return request
        }()
        
        static let Admin: UserRequest.CreateUpdateUser = {
           let request = UserRequest.CreateUpdateUser()
            request.userid = "admin"
            request.displayname = "Admin"
            request.handle = "admin"
            return request
        }()
    }
}
