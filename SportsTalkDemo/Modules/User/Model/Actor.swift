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
        return name + " " + "@\(handle)"
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
        
        self.handle = user.handle ?? ""
        self.banned = user.banned ?? false
        
        if let pictureURL = user.pictureurl {
            SDWebImageDownloader().downloadImage(with: URL(string: pictureURL)) { (image, _, _, _) in
                guard let image = image else {
                    self.avatar = Avatar(image: UIImage(systemName: "person.fill"), initials: self.handle)
                    return
                }
                
                self.avatar = Avatar(image: image, initials: self.handle)
            }
        }
    }
}

extension Actor {
    func saveLocally() {
        if !Account.manager.actors.contains(where: { $0.userId == self.userId }) {
            if self.userId == Account.manager.me?.userId {
                Account.manager.me = self
            }
            
            Account.manager.actors.append(self)
        }
    }
    
    func deleteLocally() {
        Account.manager.actors.removeAll(where: { $0.userId == self.userId })
        
        if Account.manager.me?.userId == self.userId {
            Account.manager.me = nil
        }
    }
}

extension Actor: Equatable {
    static func ==(lhs: Actor, rhs: Actor) -> Bool {
        return lhs.userId == rhs.userId
    }
}

struct Actors {
    struct Create {
        struct Request {
            static let Me: UserRequest.GetUserDetails = {
                let request = UserRequest.GetUserDetails(
                    userid: "demoappv001me"
                )
                return request
            }()
            
            static let Eugene: UserRequest.CreateUpdateUser = {
               let request = UserRequest.CreateUpdateUser(
                userid: "demoappv001eugene",
                handle: "youj",
                displayname: "Eugene",
                pictureurl:
                    URL(string: "https://media.istockphoto.com/photos/portrait-of-chinese-young-mustached-man-looking-at-camera-with-gray-picture-id1158112527?k=6&m=1158112527&s=612x612&w=0&h=6tXjyyZ_rdS7s0D6gfcr840kPeR4aUkZuAQCXvlRRTs=")
               )
                return request
            }()
            
            static let Vincent: UserRequest.CreateUpdateUser = {
               let request = UserRequest.CreateUpdateUser(
                userid: "demoappv001vincent",
                handle: "centine",
                displayname: "Vincent",
                pictureurl:
                    URL(string: "https://media.istockphoto.com/photos/upper-body-of-young-men-picture-id1082006126?k=6&m=1082006126&s=612x612&w=0&h=cXUiPDBXt09VhKYNc4IU8jxSIOuzL7u70ZLfhmh3Uos=")
               )
                return request
            }()
            
            static let Dennis: UserRequest.CreateUpdateUser = {
                let request = UserRequest.CreateUpdateUser(
                    userid: "demoappv001dennis",
                    handle: "yourhomeboydennis",
                    displayname: "Dennis",
                    pictureurl:
                        URL(string: "https://st.depositphotos.com/1771835/1478/i/450/depositphotos_14781729-stock-photo-happy-asian-doctor-folded-arms.jpg")
                )
                return request
            }()
            
            static let Alfred: UserRequest.CreateUpdateUser = {
                let request = UserRequest.CreateUpdateUser(
                    userid: "demoappv001alfred",
                    handle: "batmanhu",
                    displayname: "Alfred",
                    pictureurl:
                        URL(string: "https://st2.depositphotos.com/1550494/7408/i/450/depositphotos_74089543-stock-photo-male-butler-wearing-formal-tuxedo.jpg")
                )
                return request
            }()
            
            static let Admin: UserRequest.CreateUpdateUser = {
               let request = UserRequest.CreateUpdateUser(
                userid: "admin",
                handle: "admin",
                displayname: "Admin"
               )
                return request
            }()
        }
    }
    
    struct Search {
        struct Request {
            static let Admin: UserRequest.SearchUser = {
                let request = UserRequest.SearchUser()
                request.userid = "admin"
                return request
            }()
            
            static let Eugene: UserRequest.SearchUser = {
                let request = UserRequest.SearchUser()
                request.userid = "demoappv001eugene"
                return request
            }()
            
            static let Vincent: UserRequest.SearchUser = {
                let request = UserRequest.SearchUser()
                request.userid = "demoappv001vincent"
                return request
            }()
            
            static let Dennis: UserRequest.SearchUser = {
                let request = UserRequest.SearchUser()
                request.userid = "demoappv001dennis"
                return request
            }()
            
            static let Alfred: UserRequest.SearchUser = {
                let request = UserRequest.SearchUser()
                request.userid = "demoappv001alfred"
                return request
            }()
        }
    }
}
