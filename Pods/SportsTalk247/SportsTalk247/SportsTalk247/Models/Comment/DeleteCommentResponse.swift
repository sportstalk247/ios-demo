//
//  DeleteCommentResponse.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public class DeleteCommentResponse: Codable {
    public var kind: String?
    public var permanentdelete: Bool?
    public var comment: Comment?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case permanentdelete
        case comment
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.permanentdelete = try container.decodeIfPresent(Bool.self, forKey: .permanentdelete)
        self.comment = try container.decodeIfPresent(Comment.self, forKey: .comment)
    }
    
}
