//
//  ReportedUser.swift
//  SportsTalk247
//
//  Created by Angelo Lesano on 2/15/21.
//  Copyright © 2021 krishna41. All rights reserved.
//

import Foundation

public struct ReportedUser: Codable {
    public var userid: String?
    public var reportedbyuserid: String?
    public var reason: ReportType?
    public var added: Date?
    
    private enum CodingKeys: String, CodingKey {
        case userid
        case reportedbyuserid
        case reason
        case added
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.reportedbyuserid = try container.decodeIfPresent(String.self, forKey: .reportedbyuserid)
        
        if let type = try container.decodeIfPresent(String.self, forKey: .reason) {
            reason = ReportType(rawValue: type)
        }
        
        if let ts = try container.decodeIfPresent(String.self, forKey: .added) {
            added = ISODateFormat(ts)
        }
    }
}
