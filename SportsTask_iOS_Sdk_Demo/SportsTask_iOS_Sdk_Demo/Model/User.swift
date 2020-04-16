import Foundation

class User: NSObject
{
    var userid: String?
    var handle: String?
    var profileurl: String?
    var banned: Int?
    var displayname: String?
    var handlelowercase: String?
    var pictureurl: String?
    var kind: String?
    
    func convertIntoModel(response:[String:Any]) -> User
    {
        if let userid = response["userid"] as? String
        {
            self.userid = userid
        }
        
        if let handle = response["handle"] as? String
        {
            self.handle = handle
        }
        
        if let profileurl = response["profileurl"] as? String
        {
            self.profileurl = profileurl
        }
        
        if let banned = response["banned"] as? Int
        {
            self.banned = banned
        }
        
        if let displayname = response["displayname"] as? String
        {
            self.displayname = displayname
        }
        
        if let handlelowercase = response["handlelowercase"] as? String
        {
            self.handlelowercase = handlelowercase
        }
        
        if let pictureurl = response["pictureurl"] as? String
        {
            self.pictureurl = pictureurl
        }
        
        if let kind = response["kind"] as? String
        {
            self.kind = kind
        }

        return self
    }
    
    func getUrlString() -> String{
       return pictureurl ?? ""
    }
}

