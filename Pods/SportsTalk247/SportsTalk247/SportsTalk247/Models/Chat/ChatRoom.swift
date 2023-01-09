import Foundation

open class ChatRoom: Codable {
    public var kind: String?
    public var id: String?
    public var appid: String?
    public var ownerid: String?
    public var name: String?
    public var description: String?
    public var customtype: String?
    public var customid: String?
    public var custompayload: String?
    public var customtags: [String]?
    public var customfield1: String?
    public var customfield2: String?
    public var enableactions: Bool?
    public var enableenterandexit: Bool?
    public var open: Bool?
    public var inroom: Int?
    public var moderation: String?
    public var maxreports: Int64?
    public var enableautoexpiresessions: Bool?
    public var enableprofanityfilter: Bool?
    public var delaymessageseconds: Int64?
    public var added: Date?
    public var whenmodified: Date?
    public var bouncedusers: [String] = []
    public var reportedusers: [ReportedUser] = []
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case appid
        case ownerid
        case name
        case description
        case customtype
        case customid
        case custompayload
        case customtags
        case customfield1
        case customfield2
        case enableactions
        case enableenterandexit
        case open
        case inroom
        case added
        case whenmodified
        case moderation
        case maxreports
        case enableautoexpiresessions
        case enableprofanityfilter
        case delaymessageseconds
        case bouncedusers
        case reportedusers
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.appid = try container.decodeIfPresent(String.self, forKey: .appid)
        self.ownerid = try container.decodeIfPresent(String.self, forKey: .ownerid)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.customtype = try container.decodeIfPresent(String.self, forKey: .customtype)
        self.customid = try container.decodeIfPresent(String.self, forKey: .customid)
        self.custompayload = try container.decodeIfPresent(String.self, forKey: .custompayload)
        self.customtags = try container.decodeIfPresent(Array<String>.self, forKey: .customtags)
        self.customfield1 = try container.decodeIfPresent(String.self, forKey: .customfield1)
        self.customfield2 = try container.decodeIfPresent(String.self, forKey: .customfield2)
        self.enableactions = try container.decodeIfPresent(Bool.self, forKey: .enableactions)
        self.enableenterandexit = try container.decodeIfPresent(Bool.self, forKey: .enableenterandexit)
        self.open = try container.decodeIfPresent(Bool.self, forKey: .open)
        self.inroom = try container.decodeIfPresent(Int.self, forKey: .inroom)
        self.moderation = try container.decodeIfPresent(String.self, forKey: .moderation)
        self.maxreports = try container.decodeIfPresent(Int64.self, forKey: .maxreports)
        self.enableautoexpiresessions = try container.decodeIfPresent(Bool.self, forKey: .enableautoexpiresessions)
        self.enableprofanityfilter = try container.decodeIfPresent(Bool.self, forKey: .enableprofanityfilter)
        self.delaymessageseconds = try container.decodeIfPresent(Int64.self, forKey: .delaymessageseconds)
        self.bouncedusers = try container.decodeIfPresent([String].self, forKey: .bouncedusers) ?? []
        self.reportedusers = try container.decodeIfPresent([ReportedUser].self, forKey: .reportedusers) ?? []
        
        if let added = try container.decodeIfPresent(String.self, forKey: .added) {
            self.added = ISODateFormat(added)
        }
        
        if let modified = try container.decodeIfPresent(String.self, forKey: .whenmodified) {
            self.whenmodified = ISODateFormat(modified)
        }
    }
}
