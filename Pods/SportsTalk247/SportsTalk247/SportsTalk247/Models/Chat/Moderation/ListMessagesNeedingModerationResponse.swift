import Foundation

public struct ListMessagesNeedingModerationResponse: Codable {
    public var kind: String?
    public var events: [Event]
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case events
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.events = try container.decodeIfPresent(Array<Event>.self, forKey: .events) ?? []
    }
}
