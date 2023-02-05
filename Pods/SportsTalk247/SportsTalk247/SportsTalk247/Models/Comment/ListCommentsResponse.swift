//
//  ListCommentsResponse.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public class ListCommentsResponse: Codable {
    public var kind: String?    /* "list.comments" */
    public var cursor: String?
    public var more: Bool?
    public var itemcount: Int64?
    public var conversation: Conversation?
    public var comments: [Comment] = []
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case cursor
        case more
        case itemcount
        case conversation
        case comments
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.more = try container.decodeIfPresent(Bool.self, forKey: .more)
        self.itemcount = try container.decodeIfPresent(Int64.self, forKey: .itemcount)
        self.conversation = try container.decodeIfPresent(Conversation.self, forKey: .conversation)
        self.comments = try container.decodeIfPresent([Comment].self, forKey: .comments) ?? []
    }
    
}
