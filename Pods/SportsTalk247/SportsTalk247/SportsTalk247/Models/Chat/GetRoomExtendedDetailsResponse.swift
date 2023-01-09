//
//  GetRoomExtendedDetailsResponse.swift
//  SportsTalk247
//
//  Created by Angelo Lesano on 6/8/21.
//  Copyright © 2021 krishna41. All rights reserved.
//

import Foundation

public struct GetRoomExtendedDetailsResponse: Codable {
    public var kind: String?
    public var details: [Details]?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case details
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.details = try container.decodeIfPresent([Details].self, forKey: .details)
    }
    
    public struct Details: Codable {
        public var room: ChatRoom?
        public var mostrecentmessagetime: Date?
        public var inroom: Int?
        
        private enum CodingKeys: String, CodingKey {
            case room
            case mostrecentmessagetime
            case inroom
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.room = try container.decodeIfPresent(ChatRoom.self, forKey: .room)
            self.inroom = try container.decodeIfPresent(Int.self, forKey: .inroom)
            
            if let messageTime = try container.decodeIfPresent(String.self, forKey: .mostrecentmessagetime) {
                mostrecentmessagetime = ISODateFormat(messageTime)
            }
        }
    }
}
