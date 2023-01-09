//
//  ListUserSubscribedRoomsResponse.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 12/14/22.
//  Copyright © 2022 krishna41. All rights reserved.
//

import Foundation

public struct ListUserSubscribedRoomsResponse: Codable {
    public var kind: String?    // "list.userroomsubscriptions"
    public var cursor: String?
    public var more: Bool?
    public var itemcount: Int64?
    public var subscriptions: [ChatSubscription] = []
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case cursor
        case more
        case itemcount
        case subscriptions
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.more = try container.decodeIfPresent(Bool.self, forKey: .more)
        self.itemcount = try container.decodeIfPresent(Int64.self, forKey: .itemcount)
        if container.contains(.subscriptions) {
            self.subscriptions = try container.decode(Array<ChatSubscription>.self, forKey: .subscriptions)
        } else {
            self.subscriptions = []
        }
    }
}

public struct ChatSubscription: Codable {
    public var kind: String?    // "chat.subscription"
    public var id: String?
    public var roomid: String?
    public var roomcustomid: String?
    public var userid: String?
    public var updated: String? // ISODateTime Format
    public var added: String?   // ISODateTime Format
    public var roomname: String?
    public var roomcustomtags: [String] = []
    public var persist: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case roomid
        case roomcustomid
        case userid
        case updated
        case added
        case roomname
        case roomcustomtags
        case persist
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.roomid = try container.decodeIfPresent(String.self, forKey: .roomid)
        self.roomcustomid = try container.decodeIfPresent(String.self, forKey: .roomcustomid)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.updated = try container.decodeIfPresent(String.self, forKey: .updated)
        self.added = try container.decodeIfPresent(String.self, forKey: .added)
        self.roomname = try container.decodeIfPresent(String.self, forKey: .roomname)
        if container.contains(.roomcustomtags) {
            self.roomcustomtags = try container.decode(Array<String>.self, forKey: .roomcustomtags)
        } else {
            self.roomcustomtags = []
        }
        
        self.persist = try container.decodeIfPresent(Bool.self, forKey: .persist)
    }
    
}
