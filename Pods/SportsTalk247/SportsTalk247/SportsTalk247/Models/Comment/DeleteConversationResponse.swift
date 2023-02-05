//
//  DeleteConversationResponse.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public class DeleteConversationResponse: Codable {
    public var kind: String?
    public var conversationid: String?
    public var userid: String?
    public var deletedconversations: Int64?
    public var deletedcomments: Int64?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case conversationid
        case userid
        case deletedconversations
        case deletedcomments
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.conversationid = try container.decodeIfPresent(String.self, forKey: .conversationid)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.deletedconversations = try container.decodeIfPresent(Int64.self, forKey: .deletedconversations)
        self.deletedcomments = try container.decodeIfPresent(Int64.self, forKey: .deletedcomments)
    }
    
}
