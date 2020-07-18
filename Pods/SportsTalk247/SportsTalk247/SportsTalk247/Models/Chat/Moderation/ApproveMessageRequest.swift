import Foundation

struct ApproveMessageRequest: Codable {
    public var approve: Bool
    
    private enum CodingKeys: String, CodingKey {
        case approve
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.approve = try container.decode(Bool.self, forKey: .approve)
    }
}
