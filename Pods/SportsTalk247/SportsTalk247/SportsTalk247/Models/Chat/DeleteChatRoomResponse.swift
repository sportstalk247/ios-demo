import Foundation

public struct DeleteChatRoomResponse: Codable {
    public var kind: String?
    public var deletedEventsCount: Int64?
    public var room: ChatRoom?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case deletedEventsCount
        case room
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.deletedEventsCount = try container.decodeIfPresent(Int64.self, forKey: .deletedEventsCount)
        self.room = try container.decodeIfPresent(ChatRoom.self, forKey: .room)
    }
    
}
