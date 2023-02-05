//
//  Reaction.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public struct Reaction: Codable {
    public var type: String?
    public var count: Int64?
    public var users: [User]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case count
        case users
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.count = try container.decodeIfPresent(Int64.self, forKey: .count)
        self.users = try container.decodeIfPresent(Array<User>.self, forKey: .users) ?? []
    }
}
