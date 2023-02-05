//
//  BatchGetConversationDetailsResponse.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public class BatchGetConversationDetailsResponse: Codable {
    public var kind: String?    /* "list.comment.conversation.details" */
    public var itemcount: Int64?
    public var conversations: [Conversation] = []
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case itemcount
        case conversations
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.itemcount = try container.decodeIfPresent(Int64.self, forKey: .itemcount)
        self.conversations = try container.decodeIfPresent([Conversation].self, forKey: .conversations) ?? []
    }
    
}
