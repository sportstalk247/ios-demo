import Foundation

class Message: NSObject
{
    var kind: String?
    var id: String?
    var roomId: String?
    var body: String?
    var added: Int?
    var eventtype: String?
    var userid: String?
    var customtype: String?
    var customid: String?
    var custompayload: String?
    var replyto: String?
    var reactions: [String]?
    var moderation: String?
    var active: String?
    var reports: [String]?
    var user: User?

    func convertIntoModel(response:[String:Any]) -> Message
    {
        if let kind = response["kind"] as? String
        {
            self.kind = kind
        }
        
        if let id = response["id"] as? String
        {
            self.id = id
        }
        
        if let roomId = response["roomId"] as? String
        {
            self.roomId = roomId
        }
        
        if let body = response["body"] as? String
        {
            self.body = body
        }
        
        if let added = response["added"] as? Int
        {
            self.added = added
        }
        
        if let eventtype = response["eventtype"] as? String
        {
            self.eventtype = eventtype
        }
        
        if let userid = response["userid"] as? String
        {
            self.userid = userid
        }
        
        if let customtype = response["customtype"] as? String
        {
            self.customtype = customtype
        }

        if let customid = response["customid"] as? String
        {
            self.customid = customid
        }
        
        if let custompayload = response["custompayload"] as? String
        {
            self.custompayload = custompayload
        }
        
        if let replyto = response["replyto"] as? String
        {
            self.replyto = replyto
        }
        
        if let reactions = response["reactions"] as? [String]
        {
            self.reactions = reactions
        }
        
        if let moderation = response["moderation"] as? String
        {
            self.moderation = moderation
        }
        
         if let active = response["active"] as? String
         {
             self.active = active
         }
         
         if let reports = response["reports"] as? [String]
         {
             self.reports = reports
         }
         
         if let user = response["user"] as? [String: Any]
         {
             self.user = User().convertIntoModel(response: user)
         }
        
        return self
    }
}

