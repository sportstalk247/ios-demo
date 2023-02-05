//
//  ListRepliesBatchResponse.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public class ListCommentRepliesBatchResponse: Codable {
    public var kind: String?
    public var repliesgroupedbyparentid: [CommentReplyGroup]
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case repliesgroupedbyparentid
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.repliesgroupedbyparentid = try container.decodeIfPresent([CommentReplyGroup].self, forKey: .repliesgroupedbyparentid) ?? []
    }
    
    public struct CommentReplyGroup: Codable {
        public var kind: String?
        public var parentid: String?
        public var comments: [Comment] = []
        
        private enum CodingKeys: String, CodingKey {
            case kind
            case parentid
            case comments
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: ListCommentRepliesBatchResponse.CommentReplyGroup.CodingKeys.self)
            self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
            self.parentid = try container.decodeIfPresent(String.self, forKey: .parentid)
            self.comments = try container.decodeIfPresent([Comment].self, forKey: .comments) ?? []
        }
    }
    
}
