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
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.profileurl = try container.decodeIfPresent(String.self, forKey: .profileurl)
        self.banned = try container.decodeIfPresent(Bool.self, forKey: .banned)
        self.displayname = try container.decodeIfPresent(String.self, forKey: .displayname)
        self.handlelowercase = try container.decodeIfPresent(String.self, forKey: .handlelowercase)
        self.pictureurl = try container.decodeIfPresent(String.self, forKey: .pictureurl)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
    }
    
    public func convertIntoModel(response:[String:Any]) -> User {
        if let userid = response["userid"] as? String {
            self.userid = userid
        }
        
        if let handle = response["handle"] as? String {
            self.handle = handle
        }
        
        if let profileurl = response["profileurl"] as? String {
            self.profileurl = profileurl
        }
        
        if let banned = response["banned"] as? Bool {
            self.banned = banned
        }
        
        if let displayname = response["displayname"] as? String {
            self.displayname = displayname
        }
        
        if let handlelowercase = response["handlelowercase"] as? String {
            self.handlelowercase = handlelowercase
        }
        
        if let pictureurl = response["pictureurl"] as? String {
            self.pictureurl = pictureurl
        }
        
        if let kind = response["kind"] as? String {
            self.kind = kind
        }

        return self
    }
    
    public func getUrlString() -> String {
       return pictureurl ?? ""
    }
}

