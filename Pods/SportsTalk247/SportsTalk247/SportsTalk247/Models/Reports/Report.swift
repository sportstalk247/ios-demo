//
//  Report.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/14/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public struct Report: Codable {
    public var userid: String?
    public var reason: String?
    
    private enum CodingKeys: String, CodingKey {
        case userid
        case reason
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }
    
    public init(userId: String?, reason: String?) {
        self.userid = userId
        self.reason = reason
    }
}
