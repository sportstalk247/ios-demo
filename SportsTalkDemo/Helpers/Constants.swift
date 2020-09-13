//
//  Constants.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 5/26/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import SportsTalk247

// MARK: - Names and Identifiers
struct Storyboard {
    static let Main = UIStoryboard(name: "Main", bundle: nil)
    static let User = UIStoryboard(name: "User", bundle: nil)
    static let Admin = UIStoryboard(name: "Admin", bundle: nil)
}

struct Segue {
    struct User {
        static let showRoom = "showRoom"
        static let presentUserProfile = "presentUserProfile"
    }
    
    struct Admin {
        static let presentAddRoom = "presentAddRoom"
        static let showInhabitants = "showInhabitants"
        static let presentUserProfile = "presentUserProfile"
    }
}
