import Foundation

let acceptHeaderTitle = "Accept"
let contentTypeTitle = "Content-Type"
let tokenTitle = "x-api-token"
let authorization = "Authorization"

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
    private static let c = "chat/roomsbycustomid/"
    private static let cu = "chat/user/"
    private static let m = "chat/moderation/queues/events/"
    private static let n = "notification/"
    
    struct User {
        static func CreateUpdate(userid: String) -> String                     { return u + (userid) }
        static func Delete(userid: String) -> String                           { return u + (userid) }
        static func GetDetails(userid: String) -> String                       { return u + (userid) }
        static func List() -> String                                            { return u }
        static func Ban(userid: String) -> String                              { return u + (userid) + "/ban" }
        static func GlobalPurge(userid: String) -> String                      { return u + (userid) + "/globalpurge"}
        static func Search() -> String                                          { return s }
        static func Mute(userid: String) -> String                             { return u + (userid) + "/mute" }
        static func Report(userid: String) -> String                           { return u + (userid) + "/report" }
        static func ShadowBan(userid: String) -> String                        { return u + (userid) + "/shadowban" }
        static func ListNotifications(userid: String) -> String                { return u + (userid) + "/\(n)listnotifications/" }
        static func MarkAllNotifAsRead(userid: String) -> String               { return "\(u)\(userid)/\(n)notifications_all/markread"}
        static func SetNotifRead(userid: String, noteid: String) -> String    { return "\(u)\(userid)/\(n)notifications/\(noteid)/update"}
        static func SetNotifRead(userid: String, eventid: String) -> String   { return "\(u)\(userid)/\(n)notificationsbyid/chateventid/\(eventid)/update"}
        static func DeleteNotif(userid: String, noteid: String) -> String     { return "\(u)\(userid)/\(n)notifications/\(noteid)"}
        static func DeleteNotif(userid: String, eventid: String) -> String    { return "\(u)\(userid)/\(n)notificationsbyid/chateventid/\(eventid)"}
    }
    
    struct Room {
        static func Create() -> String                                          { return r }
        static func Details(roomid: String) -> String                          { return r + (roomid)     }
        static func DetailsExtended() -> String                                 { return r + "/batch/details"   }
        static func DetailsByCustomId(customid: String) -> String              { return c + (customid)   }
        static func Delete(roomid: String) -> String                           { return r + (roomid)     }
        static func Update(roomid: String) -> String                           { return r + (roomid)     }
        static func Close(roomid: String) -> String                            { return r + (roomid)     }
        static func List() -> String                                            { return r }
        static func Participants(roomid: String) -> String                     { return r + (roomid) + "/participants" }
        static func UserSubscribedRooms(userid: String) -> String              { return cu + (userid) + "/subscriptions" }
        static func EventHistory(roomid: String) -> String                     { return r + (roomid) + "/listeventshistory" }
        static func PreviousEvent(roomid: String) -> String                    { return r + (roomid) + "/listpreviousevents" }
        static func EventByType(roomid: String) -> String                      { return r + (roomid) + "/listeventsbytype" }
        static func EventByTime(roomid: String, time: Int) -> String          { return "\(r)\(roomid)/eventsbytimestamp/list/\(time)" }
        static func Join(roomid: String) -> String                             { return r + (roomid) + "/join" }
        static func Join(customid: String) -> String                           { return c + (customid) + "/join" }
        static func Exit(roomid: String) -> String                             { return r + (roomid) + "/exit" }
        static func GetUpdates(roomid: String) -> String                       { return r + (roomid) + "/updates" }
        static func GetMoreUpdates(roomid: String) -> String                   { return r + (roomid) + "/updates" }
        static func ExecuteCommand(roomid: String) -> String                   { return r + (roomid) + "/command" }
        static func QuotedReply(roomid: String, eventid: String) -> String    { return "\(r)\(roomid)/events/\(eventid)/quote" }
        static func ThreadedReply(roomid: String, eventid: String) -> String  { return "\(r)\(roomid)/events/\(eventid)/reply" }
        static func Report(roomid: String, userid: String) -> String          { return "\(r)\(roomid)/users/\(userid)/report" }
        static func Bounce(roomid: String) -> String                           { return r + (roomid) + "/bounce" }
        static func Shadowban(roomid: String) -> String                        { return r + (roomid) + "/shadowban" }
        static func Mute(roomid: String) -> String                             { return r + (roomid) + "/mute" }
        static func SearchEvent() -> String                                     { return "chat/searchevents/" }
        static func UpdateChatEvent(roomid: String, eventid: String) -> String{ return "\(r)\(roomid)/events/\(eventid)"}
        static func KeepAlive(roomid: String, userid: String) -> String       { return "\(r)\(roomid)/sessions/\(userid)/touch" }
    }
    
    struct Event {
        static func Purge(roomid: String, userid: String) -> String                   { return r + (roomid) + "/commands/purge/" + (userid)}
        static func FlagLogicallyDeleted(roomid: String, eventid: String) -> String   { return "\(r)\(roomid)/events/\(eventid)/setdeleted" }
        static func Delete(roomid: String, eventid: String) -> String                 { return "\(r)\(roomid)/events/\(eventid)" }
        static func DeleteAll(roomid: String) -> String                                { return r + (roomid) + "/command"}
        static func ListByUser(roomid: String, userid: String) -> String              { return "\(r)\(roomid)/messagesbyuser/\(userid)" }
        static func Report(roomid: String, eventid: String) -> String                 { return "\(r)\(roomid)/events/\(eventid)/report" }
        static func React(roomid: String, eventid: String) -> String                  { return "\(r)\(roomid)/events/\(eventid)/react" }
    }
    
    struct Mod {
        static func Approve(eventid: String) -> String { return m + (eventid) + "/applydecision" }
        static func Reject(eventid: String) -> String  { return m + (eventid) + "/applydecision" }
        static func List() -> String                    { return m }
    }
}

public enum Ordering: String {
    case forward
    case backward
}

public enum EventType: String {
    case speech
    case purge
    case bounce
    case reaction
    case replace
    case remove
    case roomclosed
    case roomopened
    case action
    case reply
    case quote
    case goal
    case ad
    case announcement
    case custom
}

public enum Role: String, Codable {
    case user
    case moderator
    case admin
}

public enum ReportType: String, Codable {
    case abuse
    case spam
}

public enum RoomEntityType: String, Codable {
    case room
    case numberofparticipants = "numparticipants"
    case lastmessagetime
}
