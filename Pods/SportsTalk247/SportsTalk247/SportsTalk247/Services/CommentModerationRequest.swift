//
//  CommentModerationRequest.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/15/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public class CommentModerationRequest {
    
    ///
    /// List all the comments in the moderation queue
    ///
    /// PARAMETERS
    ///    limit: (optional) Defaults to 200. This limits how many messages to return from the queue
    ///    cursor: (optional) Provide cursor value to get the next page of results.
    ///    conversationid: (optional) Provide the ConversationID for a room to filter for only the queued events for a specific room
    ///    filterHandle: (optional) Filters using exact match for a handle of a user
    ///    filterKeyword: (optional) Filters using substring search for your string
    ///    filterModerationState: (optional) Filters for comments in the specified moderation state.
    ///         approved: Moderator approved the comment
    ///         rejected: Moderator rejected the comment
    ///         pending: A new comment was posted to a premoderation room, and is pending review, but was never reported as abuse
    ///         flagged: Enough users reported the comment that it is in the flagged state and sent to moderation queue
    ///
    public class ListCommentsInModerationQueue: ParametersBase<ListCommentsInModerationQueue.Fields, ListCommentsInModerationQueue> {
        public enum Fields {
            // Query Params
            case limit
            case cursor
            case conversationid
            case filterHandle
            case filterKeyword
            case filterModerationState
        }
        
        public var limit: Int?
        public var cursor: String?
        public var conversationid: String?
        public var filterHandle: String?
        public var filterKeyword: String?
        public var filterModerationState: CommentModerationState?
        
        public init(limit: Int? = nil, cursor: String? = nil, conversationid: String? = nil, filterHandle: String? = nil, filterKeyword: String? = nil, filterModerationState: CommentModerationState? = nil) {
            self.limit = limit
            self.cursor = cursor
            self.conversationid = conversationid
            self.filterHandle = filterHandle
            self.filterKeyword = filterKeyword
            self.filterModerationState = filterModerationState
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> ListCommentsInModerationQueue {
            set(dictionary: dictionary)
            
            let ret = ListCommentsInModerationQueue()
            ret.limit = value(forKey: .limit)
            ret.cursor = value(forKey: .cursor)
            ret.conversationid = value(forKey: .conversationid)
            ret.filterHandle = value(forKey: .filterHandle)
            ret.filterKeyword = value(forKey: .filterKeyword)
            ret.filterModerationState = CommentModerationState(rawValue: value(forKey: .filterModerationState) ?? "")
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            add(key: .limit, value: limit)
            add(key: .cursor, value: cursor)
            add(key: .conversationid, value: conversationid)
            add(key: .filterHandle, value: filterHandle)
            add(key: .filterKeyword, value: filterKeyword)
            add(key: .filterModerationState, value: filterModerationState?.rawValue)
            return toDictionary
        }
    }
    
    ///
    /// APPROVES/REJECTS a message in the moderation queue.
    ///
    /// If PRE-MODERATION is enabled for a conversation, then all messages go to the queue before they can appear in the conversation. For each incomming message, a webhook will be fired, if one is configured.
    ///
    /// If the conversation is set to use POST-MODERATION, messages will only be sent to the moderation queue if they are reported.
    ///
    /// PARAMETERS
    ///    commentid : (required) The unique ID of the comment, URL ENCODED.
    ///    approve : (required) Pass true to approve the comment or false to reject the comment.
    ///
    public class ApproveRejectComment: ParametersBase<ApproveRejectComment.Fields, ApproveRejectComment> {
        public enum Fields {
            // Path
            case commentid
            
            // Body
            case approve
        }
        
        public let commentid: String    // REQUIRED
        public let approve: Bool        // REQUIRED
        
        public init(commentid: String, approve: Bool) {
            self.commentid = commentid
            self.approve = approve
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> ApproveRejectComment {
            set(dictionary: dictionary)
            
            let ret = ApproveRejectComment(
                commentid: value(forKey: .commentid) ?? "",
                approve: value(forKey: .approve) ?? false
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .approve, value: approve)
            return toDictionary
        }
    }
    
}
