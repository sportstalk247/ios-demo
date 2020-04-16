import Foundation
public class CommentsService
{
    public class CreateUpdateConversation: ParametersBase<CreateUpdateConversation.Fields,CreateUpdateConversation>
    {
        public enum Fields
        {
            case conversationid
            case owneruserid
            case property
            case moderation
            case maxreports
            case title
            case maxcommentlen
            case open
            case tags
            case customid
            case udf1
            case udf2
        }
        
        public var conversationid: String?
        public var owneruserid: String?
        public var property: String?
        public var moderation: String?
        public var maxreports: Int?
        public var title: String?
        public var maxcommentlen: Int?
        public var open: Bool?
        public var tags: [String]?
        public var customid: String?
        public var udf1: String?
        public var udf2: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.CreateUpdateConversation
        {
            set(dictionary: dictionary)
            let ret = CreateUpdateConversation()
            ret.conversationid = value(forKey: .conversationid)
            ret.owneruserid = value(forKey: .owneruserid)
            ret.property = value(forKey: .property)
            ret.moderation = value(forKey: .moderation)
            ret.maxreports = value(forKey: .maxreports)
            ret.title = value(forKey: .title)
            ret.maxcommentlen = value(forKey: .maxcommentlen)
            ret.open = value(forKey: .open)
            ret.tags = value(forKey: .tags)
            ret.customid = value(forKey: .customid)
            ret.udf1 = value(forKey: .udf1)
            ret.udf2 = value(forKey: .udf2)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .conversationid, value:  conversationid)
            add(key: .owneruserid, value:  owneruserid)
            add(key: .property, value:  property)
            add(key: .moderation, value:  moderation)
            add(key: .maxreports, value:  maxreports)
            add(key: .title, value:  title)
            add(key: .maxcommentlen, value:  maxcommentlen)
            add(key: .open, value:  open)
            add(key: .tags, value:  tags)
            add(key: .customid, value:  customid)
            add(key: .udf1, value:  udf1)
            add(key: .udf2, value:  udf2)
            
            addRequired(key: .conversationid, value: conversationid)
            addRequired(key: .property, value: property)
            addRequired(key: .moderation, value: moderation)
            
            return toDictionary
        }
    }
    
    public class GetConversationById: ParametersBase<GetConversationById.Fields,GetConversationById>
    {
        public enum Fields
        {
            case comment_conversation_id
        }
        
        public var comment_conversation_id: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.GetConversationById {
            set(dictionary: dictionary)
            let ret = GetConversationById()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            
            return toDictionary
        }
    }
    
    public class FindConversationByIdCustomId: ParametersBase<FindConversationByIdCustomId.Fields,FindConversationByIdCustomId>
    {
        public enum Fields
        {
            case customid
        }
        
        public var customid: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.FindConversationByIdCustomId
        {
            set(dictionary: dictionary)
            let ret = FindConversationByIdCustomId()
            ret.customid = value(forKey: .customid)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .customid, value: customid)
            
            addRequired(key: .customid, value: customid)
            
            return toDictionary
        }
    }
    
    public class ListConversations: ParametersBase<ListConversations.Fields,ListConversations>
    {
        public enum Fields
        {
            case propertyid
            case cursor
            case limit
        }
        
        public var propertyid: String?
        public var cursor: String?
        public var limit: Int? = 200
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.ListConversations
        {
            set(dictionary: dictionary)
            let ret = ListConversations()
            ret.propertyid = value(forKey: .propertyid)
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .propertyid, value: propertyid)
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            addRequired(key: .propertyid, value: propertyid)
            return toDictionary
        }
    }
    
    public class ListConversationsWithFilters: ParametersBase<ListConversationsWithFilters.Fields,ListConversationsWithFilters>
    {
        public enum Fields
        {
            case propertyid
        }
        
        public var propertyid: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.ListConversationsWithFilters
        {
            set(dictionary: dictionary)
            let ret = ListConversationsWithFilters()
            ret.propertyid = value(forKey: .propertyid)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .propertyid, value: propertyid)
            addRequired(key: .propertyid, value: propertyid)
            
            return toDictionary
        }
    }
    
    public class DeleteConversation: ParametersBase<DeleteConversation.Fields,DeleteConversation>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.DeleteConversation
        {
            set(dictionary: dictionary)
            let ret = DeleteConversation()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            return toDictionary
        }
    }
    
    public class CreateAndPublishComment: ParametersBase<CreateAndPublishComment.Fields,CreateAndPublishComment>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case userid
            case body
            case replyto
            case tags
        }
        
        public var comment_conversation_id: String?
        public var userid: String?
        public var body: String?
        public var replyto: String?
        public var tags: [String]?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.CreateAndPublishComment
        {
            set(dictionary: dictionary)
            let ret = CreateAndPublishComment()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.userid = value(forKey: .userid)
            ret.body = value(forKey: .body)
            ret.replyto = value(forKey: .replyto)
            ret.tags = value(forKey: .tags)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .userid, value: userid)
            add(key: .body, value: body)
            add(key: .replyto, value: replyto)
            add(key: .tags, value: tags)
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            return toDictionary
        }
    }
    
    public class CreateAndPublishCommentNewUser: ParametersBase<CreateAndPublishCommentNewUser.Fields,CreateAndPublishCommentNewUser>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case userid
            case body
            case replyto
            case handle
            case displayname
            case pictureurl
            case profileurl
            case tags
        }
        
        public var comment_conversation_id: String?
        public var userid: String?
        public var body: String?
        public var replyto: String?
        public var handle: String?
        public var displayname: String?
        public var pictureurl: String?
        public var profileurl: String?
        public var tags: [String]?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.CreateAndPublishCommentNewUser
        {
            set(dictionary: dictionary)
            let ret = CreateAndPublishCommentNewUser()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.userid = value(forKey: .userid)
            ret.body = value(forKey: .body)
            ret.replyto = value(forKey: .replyto)
            ret.handle = value(forKey: .handle)
            ret.displayname = value(forKey: .displayname)
            ret.pictureurl = value(forKey: .pictureurl)
            ret.profileurl = value(forKey: .profileurl)
            ret.tags = value(forKey: .tags)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            toDictionary = [AnyHashable: Any]()
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .userid, value: userid)
            add(key: .body, value: body)
            add(key: .replyto, value: replyto)
            add(key: .handle, value: handle)
            add(key: .displayname, value: displayname)
            add(key: .pictureurl, value: pictureurl)
            add(key: .profileurl, value: profileurl)
            add(key: .tags, value: tags)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            addRequired(key: .handle, value: handle)
            addRequired(key: .displayname, value: displayname)
            return toDictionary
        }
    }
    
    public class ReplyToAComment: ParametersBase<ReplyToAComment.Fields,ReplyToAComment>
    {
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case userid
            case body
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        public var userid: String?
        public var body: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.ReplyToAComment
        {
            set(dictionary: dictionary)
            let ret = ReplyToAComment()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.userid = value(forKey: .userid)
            ret.body = value(forKey: .body)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .userid, value: userid)
            add(key: .body, value: body)
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            
            return toDictionary
        }
    }
    
    public class GetCommentById: ParametersBase<GetCommentById.Fields,GetCommentById>
    {
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.GetCommentById
        {
            set(dictionary: dictionary)
            let ret = GetCommentById()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            return toDictionary
        }
    }
    
    public class ListComments: ParametersBase<ListComments.Fields,ListComments>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case cursor
            case limit
            case direction
            case sort
            case includechildren
            case includeinactive
        }
        
        public var comment_conversation_id: String?
        public var cursor: String?
        public var limit: Int?
        public var direction: String?
        public var sort: String?
        public var includechildren: Bool? = false
        public var includeinactive: Bool? = false
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.ListComments
        {
            set(dictionary: dictionary)
            let ret = ListComments()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            ret.direction = value(forKey: .direction)
            ret.sort = value(forKey: .sort)
            ret.includechildren = value(forKey: .includechildren)
            ret.includeinactive = value(forKey: .includeinactive)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            add(key: .direction, value: direction)
            add(key: .sort, value: sort)
            add(key: .includechildren, value: includechildren)
            add(key: .includeinactive, value: includeinactive)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            return toDictionary
        }
    }
    
    public class ListReplies: ParametersBase<ListReplies.Fields,ListReplies>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case cursor
            case limit
            case direction
            case sort
            case includechildren
            case includeinactive
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        public var cursor: String?
        public var limit: Int? = 200
        public var direction: String?
        public var sort: String?
        public var includechildren: Bool? = false
        public var includeinactive: Bool? = false
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.ListReplies
        {
            set(dictionary: dictionary)
            let ret = ListReplies()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            ret.direction = value(forKey: .direction)
            ret.sort = value(forKey: .sort)
            ret.includechildren = value(forKey: .includechildren)
            ret.includeinactive = value(forKey: .includeinactive)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            add(key: .direction, value: direction)
            add(key: .sort, value: sort)
            add(key: .includechildren, value: includechildren)
            add(key: .includeinactive, value: includeinactive)
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            return toDictionary
        }
    }
    
    public class FlagCommentAsDeleted: ParametersBase<FlagCommentAsDeleted.Fields,FlagCommentAsDeleted>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case userid
            case deleted
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        public var userid: String?
        public var deleted: Bool? = true
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.FlagCommentAsDeleted
        {
            set(dictionary: dictionary)
            
            let ret = FlagCommentAsDeleted()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.userid = value(forKey: .userid)
            ret.deleted = value(forKey: .deleted)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .userid, value: userid)
            add(key: .deleted, value: deleted)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            
            return toDictionary
        }
    }
    
    public class DeleteCommentPermanent: ParametersBase<DeleteCommentPermanent.Fields,DeleteCommentPermanent>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case userid
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        public var userid: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.DeleteCommentPermanent
        {
            set(dictionary: dictionary)
            
            let ret = DeleteCommentPermanent()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.userid = value(forKey: .userid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .userid, value: userid)
           
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            
            return toDictionary
        }
    }
    
    public class UpdateComment: ParametersBase<UpdateComment.Fields,UpdateComment>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case userid
            case body
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        public var userid: String?
        public var body: String?
        public var comment: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.UpdateComment
        {
            set(dictionary: dictionary)
            
            let ret = UpdateComment()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.userid = value(forKey: .userid)
            ret.body = value(forKey: .body)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .userid, value: userid)
            add(key: .body, value: body)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            
            return toDictionary
        }
    }
    
    public class ReactToCommentLike: ParametersBase<ReactToCommentLike.Fields,ReactToCommentLike>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case userid
            case reaction
            case reacted
        }
        
        public var userid: String?
        public var reaction: String?
        public var reacted: Bool? = true
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.ReactToCommentLike
        {
            set(dictionary: dictionary)
            
            let ret = ReactToCommentLike()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.userid = value(forKey: .userid)
            ret.reaction = value(forKey: .reaction)
            ret.reacted = value(forKey: .reacted)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .userid, value: userid)
            add(key: .reaction, value: reaction)
            add(key: .reacted, value: reacted)
        
            addRequired(key: .userid, value: userid)
            addRequired(key: .reaction, value: reaction)
            addRequired(key: .reacted, value: reacted)
            
            return toDictionary
        }
    }
    
    public class VoteUpOrDownOnComment: ParametersBase<VoteUpOrDownOnComment.Fields,VoteUpOrDownOnComment>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case userid
            case vote
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        public var userid: String?
        public var vote: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.VoteUpOrDownOnComment
        {
            set(dictionary: dictionary)
            
            let ret = VoteUpOrDownOnComment()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.userid = value(forKey: .userid)
            ret.vote = value(forKey: .vote)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .userid, value: userid)
            add(key: .vote, value: vote)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            addRequired(key: .userid, value: userid)
            addRequired(key: .vote, value: vote)
            
            return toDictionary
        }
    }
    
    public class ReportComment: ParametersBase<ReportComment.Fields,ReportComment>
    {
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case userid
            case reporttype
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        public var userid: String?
        public var reporttype: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.ReportComment
        {
            set(dictionary: dictionary)
            
            let ret = ReportComment()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.userid = value(forKey: .userid)
            ret.reporttype = value(forKey: .reporttype)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .userid, value: userid)
            add(key: .reporttype, value: reporttype)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            addRequired(key: .userid, value: userid)
            addRequired(key: .reporttype, value: reporttype)
            
            return toDictionary
        }
    }
}
