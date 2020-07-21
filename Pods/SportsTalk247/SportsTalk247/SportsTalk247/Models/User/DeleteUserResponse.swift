import Foundation

public struct DeleteUserResponse: Codable {
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
