import Foundation

class Room
{
    var kind: String?
    var id: String?
    var appid: String?
    var ownerid: String?
    var name: String?
    var description: String?
    var iframeUrl: String?
    var slug: String?
    var enableActions: Bool?
    var enableEnterAndExit: Bool?
    var open: Bool?
    var inroom: Int?
    var whenmodified: String?
    var moderation: String?
    var maxreports: Int?
    
    func convertIntoModel(response:[String:Any]) -> Room
    {
        if let kind = response["kind"] as? String
        {
            self.kind = kind
        }
        
        if let id = response["id"] as? String
        {
            self.id = id
        }
        
        if let appid = response["appid"] as? String
        {
            self.appid = appid
        }
        
        if let ownerid = response["ownerid"] as? String
        {
            self.ownerid = ownerid
        }
        
        if let name = response["name"] as? String
        {
            self.name = name
        }
        
        if let description = response["description"] as? String
        {
            self.description = description
        }
        
        if let iframeUrl = response["iframeUrl"] as? String
        {
            self.iframeUrl = iframeUrl
        }
        
        if let slug = response["slug"] as? String
        {
            self.slug = slug
        }

        if let enableActions = response["enableActions"] as? Int
        {
            self.enableActions = NSNumber(value: enableActions).boolValue
        }
        
        if let enableEnterAndExit = response["enableEnterAndExit"] as? Int
        {
            self.enableEnterAndExit = NSNumber(value: enableEnterAndExit).boolValue
        }
        
        if let open = response["open"] as? Int
        {
            self.open = NSNumber(value: open).boolValue
        }
        
        if let inroom = response["inroom"] as? Int
        {
            self.inroom = inroom
        }
        
        if let whenmodified = response["whenmodified"] as? String
        {
            self.whenmodified = whenmodified
        }
        
         if let maxreports = response["maxreports"] as? Int
         {
             self.maxreports = maxreports
         }
                 
        return self
    }
}
