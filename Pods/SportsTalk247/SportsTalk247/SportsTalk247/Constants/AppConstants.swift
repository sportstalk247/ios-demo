import Foundation

let acceptHeaderTitle = "Accept"
let contentTypeTitle = "Content-Type"
let tokenTitle = "x-api-token"

let acceptHeaderValue = "application/json"
let contentTypeValue = "application/json"

let messageTitle = "Message"
let errorMessageTitle = "errorMessage"
let errorMessageString = "Enter a valid"
let jsonParsingError = "Error parsing json -"
let httpError = "HTTP Error:"

let emptyString = ""

let defaultLimit = "100"

struct URLPath {
    private static let u = "user/users/"
    private static let s = "user/search/"
    private static let r = "chat/rooms/"
    private static let m = "chat/moderation/queues/events/"
    
    struct User {
        static func CreateUpdate(userid: String?) -> String { return u + (userid ?? "") }
        static func Delete(userid: String?) -> String       { return u + (userid ?? "") }
        static func GetDetails(userid: String?) -> String   { return u + (userid ?? "") }
        static func List() -> String                        { return u }
        static func Ban(userid: String?) -> String          { return u + (userid ?? "") + "/ban" }
        static func Search() -> String                      { return s }
    }
    
    struct Room {
        static func Create() -> String                              { return r }
        static func Details(roomid: String?) -> String              { return r + (roomid ?? "") }
        static func Delete(roomid: String?) -> String               { return r + (roomid ?? "") }
        static func Update(roomid: String?) -> String               { return r + (roomid ?? "") + "/updates"}
        static func Close(roomid: String?) -> String                { return r + (roomid ?? "") }
        static func List() -> String                                { return r }
        static func Participants(roomid: String?) -> String         { return r + (roomid ?? "") + "/participants" }
        static func EventHistory(roomid: String?) -> String         { return r + (roomid ?? "") + "/listeventshistory" }
        static func PreviousEvent(roomid: String?) -> String        { return r + (roomid ?? "") + "/listpreviousevents" }
        static func Join(roomid: String?) -> String                 { return r + (roomid ?? "") + "/join" }
        static func Join(customid: String?) -> String               { return r + (customid ?? "") + "/join" }
        static func Exit(roomid: String?) -> String                 { return r + (roomid ?? "") + "/exit" }
        static func GetUpdates(roomid: String?) -> String           { return r + (roomid ?? "") + "/updates" }
        static func ExecuteCommand(roomid: String?) -> String       { return r + (roomid ?? "") + "/command" }
        static func QuotedReply(roomid: String?) -> String          { return r + (roomid ?? "") + "/command" }
        static func ThreadedReply(roomid: String?) -> String        { return r + (roomid ?? "") + "/command" }
        static func Bounce(roomid: String?) -> String               { return r + (roomid ?? "") + "/bounce" }
    }
    
    struct Event {
        static func Purge(roomid: String?) -> String                                    { return r + (roomid ?? "") + "/command"}
        static func FlagLogicallyDeleted(roomid: String?, eventid: String?) -> String   { return "\(r)\(roomid ?? "")/events/\(eventid ?? "")" }
        static func Delete(roomid: String?, eventid: String?) -> String                 { return "\(r)\(roomid ?? "")/events/\(eventid ?? "")" }
        static func DeleteAll(roomid: String?) -> String                                { return r + (roomid ?? "") + "/command"}
        static func ListByUser(roomid: String?, userid: String?) -> String              { return "\(r)\(roomid ?? "")/messagesbyuser/\(userid ?? "")" }
        static func Report(roomid: String?, eventid: String?) -> String                 { return "\(r)\(roomid ?? "")/events/\(eventid ?? "")/report" }
        static func React(roomid: String?, eventid: String?) -> String                  { return "\(r)\(roomid ?? "")/events/\(eventid ?? "")/react" }
    }
    
    struct Mod {
        static func Approve(eventid: String?) -> String { return m + (eventid ?? "") + "/applydecision" }
        static func Reject(eventid: String?) -> String  { return m + (eventid ?? "") + "/applydecision" }
        static func List() -> String                    { return m }
    }
}
