import Foundation

public struct ListMessagesByUser: Codable {
    public var kind: String?
    public var cursor: String?
    public var events: [Event]
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case cursor
        case events
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.events = try container.decodeIfPresent(Array<Event>.self, forKey: .events) ?? []
    }
}
