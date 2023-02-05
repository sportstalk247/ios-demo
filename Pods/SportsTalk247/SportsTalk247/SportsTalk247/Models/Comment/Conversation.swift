//
//  Conversation.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

open class Conversation: Codable, Equatable {
    public var kind: String?    // "comment.conversation"
    public var id: String?
    public var appid: String?
    public var owneruserid: String?
    public var conversationid: String?
    public var property: String?    // "sportstalk247.com/apidemo"
    public var moderation: String?  /* "pre"/"post"/"na" */
    public var maxreports: Int64?   // OPTIONAL, defaults to 3
    public var enableprofanityfilter: Bool? // OPTIONAL, defaults to true
    public var title: String?
    public var maxcommentlen: Int64?
    public var commentcount: Int64?
    public var reactions: [Reaction]?
    public var likecount: Int64?
    public var open: Bool?  // OPTIONAL, defaults to true
    public var added: Date?   // OPTIONAL, Example value: "2020-05-02T08:51:53.8140055Z"
    public var whenmodified: Date?    // OPTIONAL, Example value: "2020-05-02T08:51:53.8140055Z"
    public var customtype: String?
    public var customid: String?
    public var customtags: [String]?
    public var custompayload: String?
    public var customfield1: String?
    public var customfield2: String?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case appid
        case owneruserid
        case conversationid
        case property
        case moderation
        case maxreports
        case enableprofanityfilter
        case title
        case maxcommentlen
        case commentcount
        case reactions
        case likecount
        case open
        case added
        case whenmodified
        case customtype
        case customid
        case customtags
        case custompayload
        case customfield1
        case customfield2
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.appid = try container.decodeIfPresent(String.self, forKey: .appid)
        self.owneruserid = try container.decodeIfPresent(String.self, forKey: .owneruserid)
        self.conversationid = try container.decodeIfPresent(String.self, forKey: .conversationid)
        self.property = try container.decodeIfPresent(String.self, forKey: .property)
        self.moderation = try container.decodeIfPresent(String.self, forKey: .moderation)
        self.maxreports = try container.decodeIfPresent(Int64.self, forKey: .maxreports)
        self.enableprofanityfilter = try container.decodeIfPresent(Bool.self, forKey: .enableprofanityfilter)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.maxcommentlen = try container.decodeIfPresent(Int64.self, forKey: .maxcommentlen)
        self.commentcount = try container.decodeIfPresent(Int64.self, forKey: .commentcount)
        self.reactions = try container.decodeIfPresent([Reaction].self, forKey: .reactions)
        self.likecount = try container.decodeIfPresent(Int64.self, forKey: .likecount)
        self.open = try container.decodeIfPresent(Bool.self, forKey: .open)
        if let added = try container.decodeIfPresent(String.self, forKey: .added) {
            self.added = ISODateFormat(added)
        }
        if let whenmodified = try container.decodeIfPresent(String.self, forKey: .whenmodified) {
            self.whenmodified = ISODateFormat(whenmodified)
        }
        self.customtype = try container.decodeIfPresent(String.self, forKey: .customtype)
        self.customid = try container.decodeIfPresent(String.self, forKey: .customid)
        self.customtags = try container.decodeIfPresent([String].self, forKey: .customtags)
        self.custompayload = try container.decodeIfPresent(String.self, forKey: .custompayload)
        self.customfield1 = try container.decodeIfPresent(String.self, forKey: .customfield1)
        self.customfield2 = try container.decodeIfPresent(String.self, forKey: .customfield2)
    }
    
    public static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        return lhs.conversationid == rhs.conversationid
    }
    
}
