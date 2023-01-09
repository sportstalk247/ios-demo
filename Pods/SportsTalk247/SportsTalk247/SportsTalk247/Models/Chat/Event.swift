import Foundation

open class Event: Codable, Equatable {
    public var kind: String?
    public var id: String?
    public var roomid: String?
    public var body: String?
    public var originalbody: String?
    var addedstring: String?
    public var added: Date?
    var modifiedstring: String?
    public var modified: Date?
    var tsdouble: Double?
    public var ts: Date?
    var eventtypestring: String?
    public var eventtype: EventType?
    public var userid: String?
    public var user: User?
    public var customtype: String?
    public var customid: String?
    public var custompayload: String?
    public var customtags: [String]?
    public var customfield1: String?
    public var customfield2: String?
    public var replyto: Event?
    public var parentid: String?
//    public var hierarchy: [String]?
//    public var depth: Int?
    public var edited: Bool?
    public var editedbymoderator: Bool?
    public var censored: Bool?
    public var deleted: Bool?
    public var active: Bool?
//    public var mutedby: [String]?
    public var shadowban: Bool?
//    public var hashtags: [String]?
    public var likecount: Int64?
    public var replycount: Int64?
    public var reactions: [ChatEventReaction]
    public var moderation: String?
    public var reports: [ChatEventReport]
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case roomid
        case body
        case originalbody
        case addedstring = "added"
        case modifiedstring = "modified"
        case tsdouble = "ts"
        case eventtypestring = "eventtype"
        case userid
        case user
        case customtype
        case customid
        case custompayload
        case customtags
        case replyto
        case parentid
//        case hierarchy
//        case depth
        case edited
        case editedbymoderator
        case censored
        case deleted
        case active
//        case mutedby
        case shadowban
//        case hashtags
        case likecount
        case replycount
        case reactions
        case moderation
        case reports
    }
    
    init() {
        self.kind = nil
        self.id = nil
        self.roomid = nil
        self.body = nil
        self.originalbody = nil
        self.addedstring = nil
        self.modifiedstring = nil
        self.tsdouble = nil
        self.eventtypestring = nil
        self.userid = nil
        self.user = nil
        self.customtype = nil
        self.customid = nil
        self.custompayload = nil
        self.customtags = []
        self.replyto = nil
        self.parentid = nil
//        self.hierarchy = nil
//        self.depth = nil
        self.edited = nil
        self.editedbymoderator = nil
        self.censored = nil
        self.deleted = nil
        self.active = nil
//        self.mutedby = nil
        self.shadowban = nil
//        self.hashtags = nil
        self.likecount = nil
        self.replycount = nil
        self.reactions = []
        self.moderation = nil
        self.reports = []
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.roomid = try container.decodeIfPresent(String.self, forKey: .roomid)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.originalbody = try container.decodeIfPresent(String.self, forKey: .originalbody)
        if let added = try container.decodeIfPresent(String.self, forKey: .addedstring) {
            self.added = ISODateFormat(added)
        }
        if let modified = try container.decodeIfPresent(String.self, forKey: .modifiedstring) {
            self.modified = ISODateFormat(modified)
        }
        
        if let ts = try container.decodeIfPresent(UInt64.self, forKey: .tsdouble) {
            self.ts = Date(ticks: ts)
        }
        
        if let type = try container.decodeIfPresent(String.self, forKey: .eventtypestring) {
            self.eventtype = EventType(rawValue: type)
        }
        
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
        self.customtype = try container.decodeIfPresent(String.self, forKey: .customtype)
        self.customid = try container.decodeIfPresent(String.self, forKey: .customid)
        self.custompayload = try container.decodeIfPresent(String.self, forKey: .custompayload)
        self.customtags = try container.decodeIfPresent([String].self, forKey: .customtags)
        self.replyto = try container.decodeIfPresent(Event.self, forKey: .replyto)
        self.parentid = try container.decodeIfPresent(String.self, forKey: .parentid)
//        self.hierarchy = try container.decodeIfPresent([String],self, forKey: .hierarchy)
//        self.depth = try container.decodeIfPresent(Int.self, forKey: .depth)
        self.edited = try container.decodeIfPresent(Bool.self, forKey: .edited)
        self.editedbymoderator = try container.decodeIfPresent(Bool.self, forKey: .editedbymoderator)
        self.censored = try container.decodeIfPresent(Bool.self, forKey: .censored)
        self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
        self.active = try container.decodeIfPresent(Bool.self, forKey: .active)
//        self.mutedby = try continer.decodeIfPresent([String].self, forKey: .mutedby)
        self.shadowban = try container.decodeIfPresent(Bool.self, forKey: .shadowban)
//        self.hashtags = try continer.decodeIfPresent([String].self, forKey: .hashtags)
        self.likecount = try container.decodeIfPresent(Int64.self, forKey: .likecount)
        self.replycount = try container.decodeIfPresent(Int64.self, forKey: .replycount)
        self.reactions = try container.decodeIfPresent(Array<ChatEventReaction>.self, forKey: .reactions) ?? []
        self.moderation = try container.decodeIfPresent(String.self, forKey: .moderation)
        self.reports = try container.decodeIfPresent(Array<ChatEventReport>.self, forKey: .reports) ?? []
    }
    
    public static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct ChatEventReaction: Codable {
    public var type: String?
    public var count: Int64?
    public var users: [User]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case count
        case users
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.count = try container.decodeIfPresent(Int64.self, forKey: .count)
        self.users = try container.decodeIfPresent(Array<User>.self, forKey: .users) ?? []
    }
    
    public init(type: String, count: Int64, users: [User]) {
        self.type = type
        self.count = count
        self.users = users
    }
}

public struct ChatEventReport: Codable {
    public var userid: String?
    public var reason: String?
    
    private enum CodingKeys: String, CodingKey {
        case userid
        case reason
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }
    
    public init(userId: String?, reason: String?) {
        self.userid = userId
        self.reason = reason
    }
}

internal func ISODateFormat(_ string: String) -> Date? {
    if #available(iOS 11.3, *) {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.formatOptions = [.withFullDate,
                                   .withFullTime,
                                   .withDashSeparatorInDate,
                                   .withFractionalSeconds]
        return formatter.date(from: string)
    } else {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter.date(from: string)
    }
}
