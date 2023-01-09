import Foundation

public struct ApiResponse<T: Codable>: Codable {
    var kind: String?
    var message: String?
    var code: Int?
    /*var errors: Dictionary<String, Any>?*/
    var data: T?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case message = "message"
        case code
        case data
    }
    
    init(code: Int, message: String? = nil) {
        self.kind = nil
        self.message = message
        self.code = code
        self.data = nil
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
        self.data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}

struct NullCodable: Codable {
}
