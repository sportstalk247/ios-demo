import Foundation

open class UserNotification: Codable {
    public var kind: String?
    public var id: String?
    public var added: Date?
    public var userid: String?
    public var ts: Date?
    public var whenread: String?
    public var isread: Bool?
    public var notificationtype: String?
    public var chatroomid: String?
    public var chatroomcustomid: String?
    public var commentconversationid: String?
    public var commentconversationcustomid: String?
    public var chateventid: String?
    public var commentid: String?
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case id
        case added
        case userid
        case ts
        case whenread
        case isread
        case notificationtype
        case chatroomid
        case chatroomcustomid
        case commentconversationid
        case commentconversationcustomid
        case chateventid
        case commentid
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.userid = try container.decodeIfPresent(String.self, forKey: .userid)
        self.whenread = try container.decodeIfPresent(String.self, forKey: .whenread)
        self.isread = try container.decodeIfPresent(Bool.self, forKey: .isread)
        self.notificationtype = try container.decodeIfPresent(String.self, forKey: .notificationtype)
        self.chatroomid = try container.decodeIfPresent(String.self, forKey: .chatroomid)
        self.chatroomcustomid = try container.decodeIfPresent(String.self, forKey: .chatroomcustomid)
        self.commentconversationid = try container.decodeIfPresent(String.self, forKey: .commentconversationid)
        self.commentconversationcustomid = try container.decodeIfPresent(String.self, forKey: .commentconversationcustomid)
        self.chateventid = try container.decodeIfPresent(String.self, forKey: .chateventid)
        self.commentid = try container.decodeIfPresent(String.self, forKey: .commentid)
        
        if let added = try container.decodeIfPresent(String.self, forKey: .added) {
            self.added = ISODateFormat(added)
        }
        
        if let ts = try container.decodeIfPresent(Double.self, forKey: .ts) {
            self.ts = Date(timeIntervalSince1970: ts)
        }
    }
}
