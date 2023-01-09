import Foundation

open class User: NSObject, Codable {
    public var kind: String?
    public var userid: String?
    public var handle: String?
    public var profileurl: String?
    public var banned: Bool?
    public var banexpires: Date?
    public var shadowbanned: Bool?
    public var shadowbanexpires: Date?
    public var muted: Bool?
    public var muteexpires: Date?
    public var moderation: String?
    public var displayname: String?
    public var handlelowercase: String?
    public var pictureurl: String?
    public var reports: [UserReport]?
    public var role: Role?
    public var customtags: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case userid
        case handle
        case profileurl
        case banned
        case banexpires
        case shadowbanned
        case shadowbanexpires
        case muted
        case muteexpires
        case moderation
        case displayname
        case handlelowercase
        case pictureurl
        case reports
        case role
        case customtags
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.handle = try container.decodeIfPresent(String.self, forKey: .handle)
        self.profileurl = try container.decodeIfPresent(String.self, forKey: .profileurl)
        self.banned = try container.decodeIfPresent(Bool.self, forKey: .banned)
        self.shadowbanned = try container.decodeIfPresent(Bool.self, forKey: .shadowbanned)
        self.muted = try container.decodeIfPresent(Bool.self, forKey: .muted)
        self.displayname = try container.decodeIfPresent(String.self, forKey: .displayname)
        self.handlelowercase = try container.decodeIfPresent(String.self, forKey: .handlelowercase)
        self.pictureurl = try container.decodeIfPresent(String.self, forKey: .pictureurl)
        self.customtags = try container.decodeIfPresent([String].self, forKey: .customtags)
        
        if let reports = try container.decodeIfPresent([UserReport].self, forKey: .reports) {
            self.reports = reports
        } else {
            self.reports = [UserReport]()
        }
        
        if let banexpires = try container.decodeIfPresent(String.self, forKey: .banexpires) {
            self.banexpires = ISODateFormat(banexpires)
        }
        
        if let shadowbanexpires = try container.decodeIfPresent(String.self, forKey: .shadowbanexpires) {
            self.shadowbanexpires = ISODateFormat(shadowbanexpires)
        }
        
        if let muteexpires = try container.decodeIfPresent(String.self, forKey: .muteexpires) {
            self.muteexpires = ISODateFormat(muteexpires)
        }
        
        if let role = try container.decodeIfPresent(String.self, forKey: .role) {
            self.role = Role(rawValue: role)
        }
    }
}

