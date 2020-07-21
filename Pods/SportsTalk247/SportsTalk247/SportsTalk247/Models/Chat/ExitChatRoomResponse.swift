import Foundation

public struct ExitChatRoomResponse: Codable {
    public var kind: String?
    
    private enum CodingKeys: String, CodingKey {
        case kind
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
    }
}
