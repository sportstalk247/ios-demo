//
//  Comment.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

open class Comment: Codable, Equatable {
    
    public var kind: String?    // "comment.comment"
    public var id: String?
    public var appid: String?
    public var conversationid: String?
    public var commenttype: String? // "comment"
    public var added: Date?
    public var modified: Date?
    public var tsunix: Int64?
    public var userid: String?
    public var user: User?
    public var body: String?
    public var originalbody: String?
    public var hashtags: [String]?
    public var shadowban: Bool?
    public var customtype: String?
    public var customid: String?
    public var custompayload: String?
    public var customtags: [String]?
    public var customfield1: String?
    public var customfield2: String?
    public var edited: Bool?
    public var censored: Bool?
    public var deleted: Bool?
    public var parentid: String?
    public var hierarchy: [String]?
    // public var mentions: [String]?
    public var reactions: [Reaction]?
    public var likecount: Int64?
    public var replycount: Int64?
    public var votecount: Int64?
    public var votescore: Int64?
    public var votes: [Vote]?
    public var moderation: String?  // "approved", "pending", "rejected"
    public var active: Bool?
    public var reports: [Report]?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case appid
        case conversationid
        case commenttype
        case added
        case modified
        case tsunix
        case userid
        case user
        case body
        case originalbody
        case hashtags
        case shadowban
        case customtype
        case customid
        case custompayload
        case customtags
        case customfield1
        case customfield2
        case edited
        case censored
        case deleted
        case parentid
        case hierarchy
        // case mentions
        case reactions
        case likecount
        case replycount
        case votecount
        case votescore
        case votes
        case moderation
        case active
        case reports
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.appid = try container.decodeIfPresent(String.self, forKey: .appid)
        self.conversationid = try container.decodeIfPresent(String.self, forKey: .conversationid)
        self.commenttype = try container.decodeIfPresent(String.self, forKey: .commenttype)
        if let addedStr = try container.decodeIfPresent(String.self, forKey: .added) {
            self.added = ISODateFormat(addedStr)
        }
        if let modifiedStr = try container.decodeIfPresent(String.self, forKey: .modified) {
            self.modified = ISODateFormat(modifiedStr)
        }
        self.tsunix = try container.decodeIfPresent(Int64.self, forKey: .tsunix)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.originalbody = try container.decodeIfPresent(String.self, forKey: .originalbody)
        self.hashtags = try container.decodeIfPresent([String].self, forKey: .hashtags)
        self.shadowban = try container.decodeIfPresent(Bool.self, forKey: .shadowban)
        self.customtype = try container.decodeIfPresent(String.self, forKey: .customtype)
        self.customid = try container.decodeIfPresent(String.self, forKey: .customid)
        self.custompayload = try container.decodeIfPresent(String.self, forKey: .custompayload)
        self.customtags = try container.decodeIfPresent([String].self, forKey: .customtags)
        self.customfield1 = try container.decodeIfPresent(String.self, forKey: .customfield1)
        self.customfield2 = try container.decodeIfPresent(String.self, forKey: .customfield2)
        self.edited = try container.decodeIfPresent(Bool.self, forKey: .edited)
        self.censored = try container.decodeIfPresent(Bool.self, forKey: .censored)
        self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
        self.parentid = try container.decodeIfPresent(String.self, forKey: .parentid)
        self.hierarchy = try container.decodeIfPresent([String].self, forKey: .hierarchy)
        //self.mentions = try container.decodeIfPresent([String].self, forKey: .mentions)
        self.reactions = try container.decodeIfPresent([Reaction].self, forKey: .reactions)
        self.likecount = try container.decodeIfPresent(Int64.self, forKey: .likecount)
        self.replycount = try container.decodeIfPresent(Int64.self, forKey: .replycount)
        self.votecount = try container.decodeIfPresent(Int64.self, forKey: .votecount)
        self.votescore = try container.decodeIfPresent(Int64.self, forKey: .votescore)
        self.votes = try container.decodeIfPresent([Vote].self, forKey: .votes)
        self.moderation = try container.decodeIfPresent(String.self, forKey: .moderation)
        self.active = try container.decodeIfPresent(Bool.self, forKey: .active)
        self.reports = try container.decodeIfPresent([Report].self, forKey: .reports)
    }
    
    public static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }
    
    public struct Vote: Codable {
        public var type: VoteType?
        public var count: Int64?
        public var users: [User]?
        
        private enum CodingKeys: String, CodingKey {
            case type
            case count
            case users
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: Comment.Vote.CodingKeys.self)
            if let voteType = type?.rawValue {
                try container.encode(voteType, forKey: .type)
            }
            if let count {
                try container.encode(count, forKey: .count)
            }
            if let users {
                try container.encode(users, forKey: .users)
            }
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Comment.Vote.CodingKeys.self)
            if let voteType = try container.decodeIfPresent(String.self, forKey: .type) {
                self.type = VoteType(rawValue: voteType)
            }
            self.count = try container.decodeIfPresent(Int64.self, forKey: .count)
            self.users = try container.decodeIfPresent([User].self, forKey: .users)
        }
        
    }
    
}

