import Foundation
public class ModerationServices
{
    public class BanUser: ParametersBase<BanUser.Fields, BanUser>
    {
        public enum Fields
        {
            case userid
            case banned
        }

        public var userid: String?
        public var banned = "true"

        override public func from(dictionary: [AnyHashable: Any]) -> BanUser
        {
            set(dictionary: dictionary)
            let ret = BanUser()

            ret.userid = value(forKey: .userid)
            ret.banned = value(forKey: .banned) ?? "true"

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .userid, value: userid)
            addRequired(key: .banned, value: banned)

            return toDictionary
        }
    }
    
    public class RestoreUser: ParametersBase<BanUser.Fields, RestoreUser>
    {
        public enum Fields
        {
            case userid
            case banned
        }

        public var userid: String?
        public var banned: Bool? = false

        override public func from(dictionary: [AnyHashable: Any]) -> RestoreUser
        {
            set(dictionary: dictionary)
            let ret = RestoreUser()

            ret.userid = value(forKey: .userid)
            ret.banned = value(forKey: .banned)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .userid, value: userid)
            addRequired(key: .banned, value: banned)

            return toDictionary
        }
    }
    
    public class PurgeUserMessages: ParametersBase<PurgeUserMessages.Fields, PurgeUserMessages>
    {
        public enum Fields
        {
            case command
            case chatroomid
            case userid
        }
        
        public var userid: String?
        public var chatroomid: String?
        public var command: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> PurgeUserMessages
        {
            set(dictionary: dictionary)
            let ret = PurgeUserMessages()
            
            ret.userid = value(forKey: .userid)
            ret.chatroomid = value(forKey: .chatroomid)
            ret.command = value(forKey: .command)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .chatroomid, value: chatroomid)
            add(key: .userid, value: userid)
            add(key: .command, value: command)
            
            return toDictionary
        }
    }
    
    public class DeleteAllEventsInRoom: ParametersBase<DeleteAllEventsInRoom.Fields, DeleteAllEventsInRoom>
    {
        public enum Fields
        {
            case command
            case chatroomid
            case userid
        }
        
        public var userid: String?
        public var chatroomid: String?
        public var command: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> DeleteAllEventsInRoom
        {
            set(dictionary: dictionary)
            let ret = DeleteAllEventsInRoom()
            
            ret.userid = value(forKey: .userid)
            ret.chatroomid = value(forKey: .chatroomid)
            ret.command = value(forKey: .command)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .chatroomid, value: chatroomid)
            add(key: .userid, value: userid)
            add(key: .command, value: command)
            
            return toDictionary
        }
    }
    
    public class RemoveMessage: ParametersBase<RemoveMessage.Fields, RemoveMessage>
    {
        public enum Fields
        {
            case chatRoomId
            case chatMessageId
        }
        
        public var chatRoomId: String?
        public var chatMessageId: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> RemoveMessage
        {
            set(dictionary: dictionary)
            let ret = RemoveMessage()
            
            ret.chatRoomId = value(forKey: .chatRoomId)
            ret.chatMessageId = value(forKey: .chatMessageId)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .chatRoomId, value: chatRoomId)
            addRequired(key: .chatMessageId, value: chatMessageId)
            
            return toDictionary
        }
    }
    
    public class ReportMessage: ParametersBase<ReportMessage.Fields, ReportMessage>
    {
        public enum Fields
        {
            case chatRoomId
            case chatMessageId
            case chat_room_newest_speech_id
            case userid
            case reporttype
        }
        
        public var chatRoomId: String?
        public var chatMessageId: String?
        public var chat_room_newest_speech_id: String?
        public var userid: String?
        public var reporttype = "abuse"
        
        override public func from(dictionary: [AnyHashable: Any]) -> ReportMessage
        {
            set(dictionary: dictionary)
            let ret = ReportMessage()
            
            ret.chatRoomId = value(forKey: .chatRoomId)
            ret.chatMessageId = value(forKey: .chatMessageId)
            ret.chat_room_newest_speech_id = value(forKey: .chat_room_newest_speech_id)
            ret.userid = value(forKey: .userid)
            ret.reporttype = value(forKey: .reporttype) ?? "abuse"
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .reporttype, value: reporttype)
            
            return toDictionary
        }
    }
    
    public class ApproveMessage: ParametersBase<ApproveMessage.Fields, ApproveMessage>
    {
        public enum Fields
        {
            case chatRoomId
            case chatMessageId
            case approve
        }
        
        public var chatRoomId: String?
        public var chatMessageId: String?
        public var approve: Bool?  = true
        
        override public func from(dictionary: [AnyHashable: Any]) -> ApproveMessage
        {
            set(dictionary: dictionary)
            let ret = ApproveMessage()
            
            ret.chatRoomId = value(forKey: .chatRoomId)
            ret.chatMessageId = value(forKey: .chatMessageId)
            ret.approve = value(forKey: .approve)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .approve, value: approve)
            addRequired(key: .chatRoomId, value: chatRoomId)
            addRequired(key: .chatMessageId, value: chatMessageId)
            
            return toDictionary
        }
    }
}
