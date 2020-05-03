import Foundation
struct Report{
    let userid: String
    let reason: String
    
    static func from(dict: [String:Any]) -> Report{
        let userid = dict["userid"] as? String ?? ""
        let reason = dict["reason"] as? String ?? ""
        return Report(userid: userid, reason: reason)
    }
}
