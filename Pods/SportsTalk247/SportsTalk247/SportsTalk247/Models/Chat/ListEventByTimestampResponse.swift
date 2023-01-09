import Foundation

public struct ListEventByTimestampResponse: Codable {
    public var kind: String?
    public var cursorolder: String?
    public var cursornewer: String?
    public var timestampolder: Int?
    public var timestampnewer: Int?
    public var hasmoreolder: Bool?
    public var hasmorenewer: Bool?
    public var itemcount: Int64?
    public var events: [Event]
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case cursorolder
        case cursornewer
        case timestampolder
        case timestampnewer
        case hasmoreolder
        case hasmorenewer
        case itemcount
        case events
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.cursorolder = try container.decodeIfPresent(String.self, forKey: .cursorolder)
        self.cursornewer = try container.decodeIfPresent(String.self, forKey: .cursornewer)
        self.timestampolder = try container.decodeIfPresent(Int.self, forKey: .timestampolder)
        self.timestampnewer = try container.decodeIfPresent(Int.self, forKey: .timestampnewer)
        self.hasmoreolder = try container.decodeIfPresent(Bool.self, forKey: .hasmoreolder)
        self.hasmorenewer = try container.decodeIfPresent(Bool.self, forKey: .hasmorenewer)
        self.itemcount = try container.decodeIfPresent(Int64.self, forKey: .itemcount)
        self.events = try container.decodeIfPresent(Array<Event>.self, forKey: .events) ?? []
    }
}
