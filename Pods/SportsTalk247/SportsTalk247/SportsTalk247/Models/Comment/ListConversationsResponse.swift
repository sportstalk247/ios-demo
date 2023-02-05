//
//  ListConversationsResponse.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public class ListConversationsResponse: Codable {
    public var kind: String?    /* "list.commentconversations" */
    public var cursor: String?
    public var more: Bool?
    public var conversations: [Conversation] = []
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case cursor
        case more
        case conversations
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.more = try container.decodeIfPresent(Bool.self, forKey: .more)
        self.conversations = try container.decodeIfPresent([Conversation].self, forKey: .conversations) ?? []
    }
    
    
}
