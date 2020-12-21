//
//  DeleteEventResponse.swift
//  SportsTalk247
//
//  Created by Angelo Lesano on 9/13/20.
//  Copyright © 2020 krishna41. All rights reserved.
//

import Foundation

public struct DeleteEventResponse: Codable {
    public var kind: String?
    public var permanentdelete: Bool?
    public var event: Event?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case permanentdelete
        case event
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.permanentdelete = try container.decodeIfPresent(Bool.self, forKey: .permanentdelete)
        self.event = try container.decodeIfPresent(Event.self, forKey: .event)
    }
    
}
