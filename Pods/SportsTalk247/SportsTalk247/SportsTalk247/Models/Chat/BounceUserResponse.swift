import Foundation

public struct BounceUserResponse: Codable {
    public var kind: String?
    public var event: Event?
    public var room: ChatRoom?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case event
        case room
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.event = try container.decodeIfPresent(Event.self, forKey: .event)
        self.room = try container.decodeIfPresent(ChatRoom.self, forKey: .room)
    }
}
