import Foundation

public class ModerationRequest {
    /// Approves a message in the moderation queue
    ///
    /// If PRE-MODERATION is enabled for a room, then all messages go to the queue before they can appear in the event stream. For each incomming message, a webhook will be fired, if one is configured.
    ///
    /// If the room is set to use POST-MODERATION, messages will only be sent to the moderation queue if they are reported.
    ///
    /// **Warning** This method requires authentication
    ///
    public class ApproveEvent: ParametersBase<ApproveEvent.Fields, ApproveEvent> {
        public enum Fields {
            case eventid
            case approve
        }
        
        public let eventid: String  // REQUIRED
        public let approve: Bool    // REQUIRED
        
        public init(eventid: String) {
            self.eventid = eventid
            self.approve = true
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ApproveEvent {
            set(dictionary: dictionary)
            let ret = ApproveEvent(
                eventid: value(forKey: .eventid) ?? ""
            )
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .approve, value: true)
            
            return toDictionary
        }
    }
    
    /// Rejects a message in the moderation queue
    ///
    /// If PRE-MODERATION is enabled for a room, then all messages go to the queue before they can appear in the event stream. For each incomming message, a webhook will be fired, if one is configured.
    ///
    /// If the room is set to use POST-MODERATION, messages will only be sent to the moderation queue if they are reported.
    ///
    /// **Warning** This method requires authentication
    ///
    public class RejectEvent: ParametersBase<RejectEvent.Fields, RejectEvent> {
        public enum Fields {
            case eventid
            case approve
        }
        
        public let eventid: String  // REQUIRED
        public let approve: Bool    // REQUIRED
        
        public init(eventid: String) {
            self.eventid = eventid
            self.approve = false
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> RejectEvent {
            set(dictionary: dictionary)
            let ret = RejectEvent(
                eventid: value(forKey: .eventid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .approve, value: false)
            
            return toDictionary
        }
    }

    
    /// List all the messages in the moderation queue
    ///
    /// **Parameters**
    ///
    /// - limit: (optional) Defaults to 200. This limits how many messages to return from the queue
    ///
    /// - roomId: (optional) Provide the ID for a room to filter for only the queued events for a specific room
    ///
    /// - cursor: (optional) Provide cursor value to get the next page of results.
    ///
    /// **Warning** This method requires authentication
    ///
    public class listMessagesInModerationQueue: ParametersBase<listMessagesInModerationQueue.Fields, listMessagesInModerationQueue> {
        public enum Fields {
            case limit
            case roomId
            case cursor
        }
       
        public let roomId: String?
        public var limit: Int?// = 200
        public var cursor: String?
        
        public init(roomId: String? = nil, limit: Int? = nil, cursor: String? = nil) {
            self.roomId = roomId
            self.limit = limit
            self.cursor = cursor
        }
       
        override public func from(dictionary: [AnyHashable: Any]) -> listMessagesInModerationQueue {
            set(dictionary: dictionary)
            let ret = listMessagesInModerationQueue(
                roomId: value(forKey: .roomId),
                limit: value(forKey: .limit),
                cursor: value(forKey: .cursor)
            )
            return ret
        }

        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            add(key: .limit, value: limit)
            add(key: .roomId, value: roomId)
            add(key: .cursor, value: cursor)
            return toDictionary
        }
    }
    
    /// APPROVES a message in the moderation queue
    ///
    /// If PRE-MODERATION is enabled for a conversation, then all messages go to the queue before they can appear in the event stream. For each incomming message, a webhook will be fired, if one is configured.
    ///
    /// If the room is set to use POST-MODERATION, messages will only be sent to the moderation queue if they are reported.
    ///
    /// **Warning** This method requires authentication
    public class ApproveCommentInQueue: ParametersBase<ApproveCommentInQueue.Fields, ApproveCommentInQueue> {
        public enum Fields {
            case commentid
            case approve
        }
        
        public var commentid: String?
        public var approve: Bool?  = true
        
        override public func from(dictionary: [AnyHashable: Any]) -> ApproveCommentInQueue {
            set(dictionary: dictionary)
            let ret = ApproveCommentInQueue()
            
            ret.commentid = value(forKey: .commentid)
            ret.approve = value(forKey: .approve)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            add(key: .approve, value: approve)
            addRequired(key: .commentid, value: commentid)
            
            return toDictionary
        }
    }
    
    /// REJECTS a message in the moderation queue
    ///
    /// If PRE-MODERATION is enabled for a conversation, then all messages go to the queue before they can appear in the event stream. For each incomming message, a webhook will be fired, if one is configured.
    ///
    /// If the room is set to use POST-MODERATION, messages will only be sent to the moderation queue if they are reported.
    ///
    ///
    /// **Warning** This method requires authentication
    public class RejectCommentInQueue: ParametersBase<RejectCommentInQueue.Fields, RejectCommentInQueue> {
        public enum Fields {
            case commentid
            case approve
        }
        
        public var commentid: String?
        public var approve: Bool?  = true
        
        override public func from(dictionary: [AnyHashable: Any]) -> RejectCommentInQueue {
            set(dictionary: dictionary)
            let ret = RejectCommentInQueue()
            
            ret.commentid = value(forKey: .commentid)
            ret.approve = value(forKey: .approve)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            add(key: .approve, value: approve)
            addRequired(key: .commentid, value: commentid)
            
            return toDictionary
        }
    }
    
    /// List all the messages in the moderation queue
    ///
    /// **Parameters**
    ///
    /// - limit: (optional) Defaults to 200. This limits how many messages to return from the queue
    ///
    /// - roomId: (optional) Provide the ID for a room to filter for only the queued events for a specific room
    ///
    /// - cursor: (optional) Provide cursor value to get the next page of results.
    ///
    /// - filterHandle: (optional) Filters using exact match for a handle of a user
    ///
    /// - filterKeyword: (optional) Filters using substring search for your string
    ///
    /// - filterModerationState: (optional) Filters for comments in the specified moderation state.
    ///
    ///     - approved: Moderator approved the comment
    ///
    ///     - rejected: Moderator rejected the comment
    ///
    ///     - pending: A new comment was posted to a premoderation room, and is pending review, but was never reported as abuse
    ///
    ///     - flagged: Enough users reported the comment that it is in the flagged state and sent to moderation queue
    ///
    /// **Warning** This method requires authentication
    ///
    public class ListCommentsInModerationQueue: ParametersBase<ListCommentsInModerationQueue.Fields, ListCommentsInModerationQueue> {
        public enum Fields {
            case limit
            case roomId
            case cursor
            case filterHandle
            case filterKeyword
            case filterModerationState
        }
        
        public var limit: Int?
        public var roomId: String?
        public var cursor: String?
        public var filterHandle: String?
        public var filterKeyword: String?
        public var filterModerationState: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListCommentsInModerationQueue {
            set(dictionary: dictionary)
            let ret = ListCommentsInModerationQueue()
            
            ret.limit = value(forKey: .limit)
            ret.roomId = value(forKey: .roomId)
            ret.cursor = value(forKey: .cursor)
            ret.filterHandle = value(forKey: .filterHandle)
            ret.filterKeyword = value(forKey: .filterKeyword)
            ret.filterModerationState = value(forKey: .filterModerationState)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            add(key: .limit, value: limit)
            add(key: .roomId, value: roomId)
            add(key: .cursor, value: cursor)
            add(key: .filterHandle, value: filterHandle)
            add(key: .filterKeyword, value: filterKeyword)
            add(key: .filterModerationState, value: filterModerationState)
            
            return toDictionary
        }
    }
}
