import Foundation

public class ChatRoomsServices
{
    public class CreateRoom: ParametersBase<CreateRoom.Fields, CreateRoom>
    {
        public enum Fields
        {
            case name
            case slug
            case description
            case enableactions
            case enableenterandexit
            case roomisopen
            case userid
        }

        public var name: String?
        public var slug: URL?
        public var description: String?
        public var enableactions: Bool?
        public var enableenterandexit: Bool?
        public var roomisopen:Bool?
        public var userid:String?

        override public func from(dictionary: [AnyHashable: Any]) -> CreateRoom
        {
            set(dictionary: dictionary)
            let ret = CreateRoom()

            ret.name = value(forKey: .name)
            ret.slug = value(forKey: .slug)
            ret.description = value(forKey: .description)
            ret.enableactions = value(forKey: .enableactions)
            ret.enableenterandexit = value(forKey: .enableenterandexit)
            ret.roomisopen = value(forKey: .roomisopen)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .name, value: name)
            add(key: .slug, value: slug?.absoluteString)
            add(key: .description, value: description)
            add(key: .enableactions, value: enableactions)
            add(key: .enableenterandexit, value: enableenterandexit)
            add(key: .roomisopen, value: roomisopen)

            return toDictionary
        }
    }
    
    public class UpdateRoom: ParametersBase<UpdateRoom.Fields, UpdateRoom>
    {
        public enum Fields
        {
            case roomid
            case name
            case slug
            case description
            case enableactions
            case enableenterandexit
            case roomisopen
            case throttle
            case userid
        }

        public var roomid: String?
        public var name: String?
        public var slug: URL?
        public var description: String?
        public var enableactions: Bool?
        public var enableenterandexit: Bool?
        public var roomisopen:Bool?
        public var userid:String?
        public var throttle:Int?

        override public func from(dictionary: [AnyHashable: Any]) -> UpdateRoom
        {
            set(dictionary: dictionary)
            let ret = UpdateRoom()

            ret.roomid = value(forKey: .roomid)
            ret.name = value(forKey: .name)
            ret.slug = value(forKey: .slug)
            ret.description = value(forKey: .description)
            ret.enableactions = value(forKey: .enableactions)
            ret.enableenterandexit = value(forKey: .enableenterandexit)
            ret.roomisopen = value(forKey: .roomisopen)
            ret.throttle = value(forKey: .throttle)
            
            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .roomid, value: roomid)
            add(key: .name, value: name)
            add(key: .slug, value: slug?.absoluteString)
            add(key: .description, value: description)
            add(key: .enableactions, value: enableactions)
            add(key: .enableenterandexit, value: enableenterandexit)
            add(key: .roomisopen, value: roomisopen)
            add(key: .throttle, value: throttle)
            
            return toDictionary
        }
    }
    
    public class UpdateRoomCloseARoom: ParametersBase<UpdateRoomCloseARoom.Fields, UpdateRoomCloseARoom>
    {
        public enum Fields
        {
            case roomid
            case roomisopen
        }

        public var roomid: String?
        public var roomisopen: Bool? = false

        override public func from(dictionary: [AnyHashable: Any]) -> UpdateRoomCloseARoom
        {
            set(dictionary: dictionary)
            let ret = UpdateRoomCloseARoom()

            ret.roomid = value(forKey: .roomid)
            ret.roomisopen = value(forKey: .roomisopen)
            
            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .roomisopen, value: roomisopen)
            
            return toDictionary
        }
    }
    
    public class ListRooms
    {
        public init() { }
        
        public func from(dictionary: [AnyHashable: Any]) -> ListRooms
        {
            let ret = ListRooms()
            
            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            return [AnyHashable: Any]()
        }
    }
    
    public class ListRoomParticipants: ParametersBase<ListRoomParticipants.Fields, ListRoomParticipants>
    {
        public enum Fields
        {
            case roomid
            case cursor
            case maxresults
        }

        public var roomid: String?
        public var cursor: String? = ""
        public var maxresults: Int? = 200

        override public func from(dictionary: [AnyHashable: Any]) -> ListRoomParticipants
        {
            set(dictionary: dictionary)
            let ret = ListRoomParticipants()

            ret.roomid = value(forKey: .roomid)
            ret.cursor = value(forKey: .cursor)
            ret.maxresults = value(forKey: .maxresults)
            
            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .cursor, value: cursor)
            add(key: .maxresults, value: maxresults)

            return toDictionary
        }
    }
    
    public class JoinRoomAuthenticatedUser: ParametersBase<JoinRoomAuthenticatedUser.Fields, JoinRoomAuthenticatedUser>
    {
        public enum Fields
        {
            case roomid
            case userid
            case handle
            case displayname
            case pictureurl
            case profileurl
        }
        
        public var roomid: String?
        public var userid: String?
        public var handle: String?
        public var displayname: String?
        public var pictureurl: URL?
        public var profileurl: URL?

        override public func from(dictionary: [AnyHashable: Any]) -> JoinRoomAuthenticatedUser
        {
            set(dictionary: dictionary)
            let ret = JoinRoomAuthenticatedUser()

            ret.roomid = value(forKey: .roomid)
            ret.userid = value(forKey: .userid)
            ret.handle = value(forKey: .handle)
            ret.displayname = value(forKey: .displayname)
            ret.pictureurl = value(forKey: .pictureurl)
            ret.profileurl = value(forKey: .profileurl)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .roomid, value: roomid)
            add(key: .userid, value: userid)
            add(key: .handle, value: handle)
            add(key: .displayname, value: displayname)
            add(key: .pictureurl, value: pictureurl?.absoluteString)
            add(key: .profileurl, value: profileurl?.absoluteString)

            return toDictionary
        }
    }
    
    public class JoinRoomAnonymousUser: ParametersBase<JoinRoomAnonymousUser.Fields, JoinRoomAnonymousUser>
    {
        public enum Fields
        {
            case roomid
        }
        
        public var roomid: String?

        override public func from(dictionary: [AnyHashable: Any]) -> JoinRoomAnonymousUser
        {
            set(dictionary: dictionary)
            let ret = JoinRoomAnonymousUser()

            ret.roomid = value(forKey: .roomid)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .roomid, value: roomid)

            return toDictionary
        }
    }
    
    public class GetUpdates: ParametersBase<GetUpdates.Fields, GetUpdates>
    {
        public enum Fields
        {
            case roomId
        }
        
        public var roomId: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetUpdates
        {
            set(dictionary: dictionary)
            let ret = GetUpdates()

            ret.roomId = value(forKey: .roomId)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .roomId, value: roomId)

            return toDictionary
        }
    }
    
    public class GetUpdatesMore: ParametersBase<GetUpdatesMore.Fields, GetUpdatesMore>
    {
        public enum Fields
        {
            case roomIdOrLabel
            case eventid
        }
        
        public var roomIdOrLabel: String?
        public var eventid: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetUpdatesMore
        {
            set(dictionary: dictionary)
            let ret = GetUpdatesMore()

            ret.roomIdOrLabel = value(forKey: .roomIdOrLabel)
            ret.eventid = value(forKey: .eventid)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .eventid, value: eventid)

            return toDictionary
        }
    }
    
    public class ExecuteChatCommand: ParametersBase<ExecuteChatCommand.Fields, ExecuteChatCommand>
    {
        public enum Fields
        {
            case roomId
            case command
            case userid
            case customtype
            case customid
            case custompayload
        }
        
        public var roomId: String?
        public var command: String?
        public var userid: String?
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?

        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteChatCommand
        {
            set(dictionary: dictionary)
            let ret = ExecuteChatCommand()

            ret.roomId = value(forKey: .roomId)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.customtype = value(forKey: .customtype)
            ret.customid = value(forKey: .customid)
            ret.custompayload = value(forKey: .custompayload)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .roomId, value: roomId)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .customtype, value: customtype)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)

            return toDictionary
        }
    }
    
    public class ExecuteDanceAction: ParametersBase<ExecuteDanceAction.Fields, ExecuteDanceAction>
    {
        public enum Fields
        {
            case roomId
            case command
            case userid
            case customtype
            case customid
            case custompayload
        }
        
        public var roomId: String?
        public var command: String?
        public var userid: String?
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteDanceAction
        {
            set(dictionary: dictionary)
            let ret = ExecuteDanceAction()
            
            ret.roomId = value(forKey: .roomId)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.customtype = value(forKey: .customtype)
            ret.customid = value(forKey: .customid)
            ret.custompayload = value(forKey: .custompayload)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomId, value: roomId)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .customtype, value: customtype)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)
            
            return toDictionary
        }
    }
    
    public class ReplyToAMessage: ParametersBase<ReplyToAMessage.Fields, ReplyToAMessage>
    {
        public enum Fields
        {
            case roomId
            case command
            case userid
            case replyto
        }
        
        public var roomId: String?
        public var command: String?
        public var userid: String?
        public var replyto: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ReplyToAMessage
        {
            set(dictionary: dictionary)
            let ret = ReplyToAMessage()
            
            ret.roomId = value(forKey: .roomId)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.replyto = value(forKey: .replyto)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomId, value: roomId)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .replyto, value: replyto)
            
            return toDictionary
        }
    }
    
    public class ReactToAMessageLike: ParametersBase<ReactToAMessageLike.Fields, ReactToAMessageLike>
    {
        public enum Fields
        {
            case roomId
            case roomNewestEventId
            case userid
            case reaction
            case reacted
        }
        
        public var roomId: String?
        public var roomNewestEventId: String?
        public var userid: String?
        public var reaction: String?
        public var reacted: Bool?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ReactToAMessageLike
        {
            set(dictionary: dictionary)
            let ret = ReactToAMessageLike()
            
            ret.roomId = value(forKey: .roomId)
            ret.roomNewestEventId = value(forKey: .roomNewestEventId)
            ret.userid = value(forKey: .userid)
            ret.reaction = value(forKey: .reaction)
            ret.reacted = value(forKey: .reacted)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomId, value: roomId)
            addRequired(key: .roomNewestEventId, value: roomNewestEventId)
            add(key: .userid, value: userid)
            add(key: .reaction, value: reaction)
            add(key: .reacted, value: reacted)
            
            return toDictionary
        }
    }
    
    public class ExecuteAdminCommand: ParametersBase<ExecuteAdminCommand.Fields, ExecuteAdminCommand>
    {
        public enum Fields
        {
            case roomId
            case command
            case userid
            case customtype
            case customid
            case custompayload
        }
        
        public var roomId: String?
        public var command: String?
        public var userid: String?
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteAdminCommand
        {
            set(dictionary: dictionary)
            let ret = ExecuteAdminCommand()
            
            ret.roomId = value(forKey: .roomId)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.customtype = value(forKey: .customtype)
            ret.customid = value(forKey: .customid)
            ret.custompayload = value(forKey: .custompayload)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomId, value: roomId)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .customtype, value: customtype)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)

            return toDictionary
        }
    }
    
    public class ExitRoom: ParametersBase<ExitRoom.Fields, ExitRoom>
    {
        public enum Fields
        {
            case roomId
            case userid
        }
        
        public var roomId: String?
        public var userid: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExitRoom
        {
            set(dictionary: dictionary)
            let ret = ExitRoom()
            
            ret.roomId = value(forKey: .roomId)
            ret.userid = value(forKey: .userid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomId, value: roomId)
            add(key: .userid, value: userid)

            return toDictionary
        }
    }
    
    public class GetRoomDetails: ParametersBase<GetRoomDetails.Fields, GetRoomDetails>
    {
        public enum Fields
        {
            case roomIdOrSlug
        }
        
        public var roomIdOrSlug: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetRoomDetails
        {
            set(dictionary: dictionary)
            let ret = GetRoomDetails()
            
            ret.roomIdOrSlug = value(forKey: .roomIdOrSlug)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomIdOrSlug, value: roomIdOrSlug)

            return toDictionary
        }
    }
}
