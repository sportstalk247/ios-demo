import Foundation

open class User: NSObject, Codable {
    public var userid: String?
    public var handle: String?
    public var profileurl: String?
    public var banned: Bool?
    public var displayname: String?
    public var handlelowercase: String?
    public var pictureurl: String?
    public var kind: String?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case userid
        case handle
        case profileurl
        case banned
        case displayname
        case handlelowercase
        case pictureurl
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.handle = try container.decodeIfPresent(String.self, forKey: .handle)
        self.profileurl = try container.decodeIfPresent(String.self, forKey: .profileurl)
        self.banned = try container.decodeIfPresent(Bool.self, forKey: .banned)
        self.displayname = try container.decodeIfPresent(String.self, forKey: .displayname)
        self.handlelowercase = try container.decodeIfPresent(String.self, forKey: .handlelowercase)
        self.pictureurl = try container.decodeIfPresent(String.self, forKey: .pictureurl)
    }
}

