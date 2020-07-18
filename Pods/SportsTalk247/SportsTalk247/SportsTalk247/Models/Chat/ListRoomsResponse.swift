import Foundation

public struct ListRoomsResponse: Codable {
    public var kind: String?
    public var cursor: String?
    public var more: Bool?
    public var itemcount: Int64?
    public var rooms: [ChatRoom]
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case cursor
        case more
        case itemcount
        case rooms
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.more = try container.decodeIfPresent(Bool.self, forKey: .more)
        self.itemcount = try container.decodeIfPresent(Int64.self, forKey: .itemcount)
        self.rooms = try container.decodeIfPresent(Array<ChatRoom>.self, forKey: .rooms) ?? []
    }
    
}
