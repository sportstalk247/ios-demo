import Foundation

public struct ListChatRoomParticipantsResponse: Codable {
    public var kind: String?
    public var cursor: String?
    public var participants: [ChatRoomParticipant]
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case cursor
        case participants
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.participants = try container.decodeIfPresent(Array<ChatRoomParticipant>.self, forKey: .participants) ?? []
    }
}

public struct ChatRoomParticipant: Codable {
    public var kind: String?
    public var user: User?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case user
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
    }
}
