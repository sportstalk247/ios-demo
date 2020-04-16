//
//  CommentConversation.swift
//  SportsTask_iOS_Sdk_Demo
//
//  Created by Admin on 15/04/20.
//  Copyright © 2020 krishna41. All rights reserved.
//

import Foundation
struct CommentConversation{
    let title: String
    let conversationid: String
    let owneruserid: String
    let open: Bool
    let property: String
    let customid: String
    let commentcount: Int
    let whenmodified: Int
    
    
    static func from(dict: [String:Any]) -> CommentConversation{
        let title = dict["title"] as? String ?? ""
        let conversationid = dict["conversationid"] as? String ?? ""
        let owneruserid = dict["owneruserid"] as? String ?? ""
        let open = dict["open"] as? Bool ?? false
        let property = dict["property"] as? String ?? ""
        let customid = dict["customid"] as? String ?? ""
        let commentcount =  dict["commentcount"] as? Int ?? 0
        let whenmodified = dict["whenmodified"] as? Int ?? 0
        
        return CommentConversation(title: title, conversationid: conversationid, owneruserid: owneruserid, open: open, property: property, customid: customid, commentcount: commentcount, whenmodified: whenmodified)
    }
}
