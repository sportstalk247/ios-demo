import Foundation
public class CommentsService
{
    
    /// Creates a conversation (a context for comments)
    ///
    /// If a conversation with the specified ID already exists, this will update it.
    ///
    /// Custom fields can be set, and can be overwritten. However, once a custom field is used it can not be set to no value (empty string).
    ///
    /// BODY PROPERTIES:
    ///
    /// * owneruserid : (optional) The application's userid representing the user who created the converation. If provided, this user is considered the "owner" and has full rights over the conversation space.
    ///
    /// * conversationid : (required) The conversation ID. This must be a URL friendly string (cannot contain / ? or other URL delimiters). Maximum length is 250 characters.
    ///
    /// * property : (required) The property this conversation is associated with. It is any string value you want. Typically this is the domain of your website for which you want to use commenting, if you have more than one. Examples:
    ///    * dev, uat, stage, prod
    ///    * website, mobile
    ///    * site1.com, site2.com
    ///
    /// * moderation : (required) Specify if pre or post moderation is to be used
    ///
    /// * maxreports : (optional, default = 3) If this number of users flags a content item in this conversation, the item is disabled and sent to moderator queue for review
    ///
    /// * title : (optional) The title of the conversation
    ///
    /// * maxcommentlen: (optional) The maximum allowed length of a comment. Default is 256 characters. Maximum value is 10485760 (10 MB)
    ///
    /// * open: (optional, defaults to true) If the conversation is open people can add comments.
    ///
    /// * customid : (optional) 250 characters for a custom ID for your app. This field is indexed for high performance object retrieval.
    ///
    /// * customtype : (optional) Custom type string.
    ///
    /// * custompayload : (optional) Custom payload string.
    ///
    /// * customfield1 : (optional) User custom field 1. Store any string value you want here, limit 1024 bytes.
    ///
    /// * customfield2 : (optional) User custom field 2. Store any string value you want here, limit 1024 bytes.
    ///
    /// * customtags : (optional) A comma delimited list of tags
    ///
    /// * maxreportss: (optiona) Default is 3. This is the maximum amount of user reported flags that can be applied to a message before it is sent to the moderation queue
    ///
    /// - Warning: This method requires authentication.
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
    
    /// Get Conversation by ID
    ///
    /// * comment_conversation_id : (required) The ID of the conversation which is a context for comments. The ID must be URL ENCODED.
    ///
    /// - Warning: This method requires authentication.
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
    
    /// Find Conversation by CustomID
    ///
    /// Uses the CustomID for the conversation supplied by the app to retrieve the conversation object. It returns exactly one object or 404 if not found. This query is covered by an index and is performant.
    ///
    /// * customid : (Required) Locates a conversation using the custom ID.
    ///
    /// - Warning: This method requires authentication.
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
    
    /// Get a list of all conversations with optional filters
    ///
    /// CURSORING:
    ///
    /// * API Method returns a cursor
    /// * Cursor includes a "more" field indicating if there are more results that can be read at the time this call is made
    /// * Cursor includes "cursor" field, which can be passed into subsequent calls to this method to get additional results
    /// * Cursor includes "itemcount" field, which is the number of items returned by the cursor not the total number of items in the database
    /// * All LIST methods in the API return cursors and they all work the same way
    ///
    /// OPTIONAL PARAMETERS:
    /// * propertyid : Filters list of conversations by property. Exact match only, case sensitive.
    /// * cursor : (Optional, default = ""). For cusoring, pass in cursor output from previous call to continue where you left off.
    /// * limit : (Optional, default = 200). For cursoring, limit the number of responses for this request.
    ///
    /// Retrieves metadata about all conversations for a property. Whenever you create a conversation, you provide a property to associate it with. This returns the metadata for all conversations associated with a property.
    ///
    /// - Warning: This method requires authentication.
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
            return toDictionary
        }
    }
    
    /// Get a list of all conversations with optional filters
    ///
    /// CURSORING:
    ///
    /// * API Method returns a cursor
    /// * Cursor includes a "more" field indicating if there are more results that can be read at the time this call is made
    /// * Cursor includes "cursor" field, which can be passed into subsequent calls to this method to get additional results
    /// * Cursor includes "itemcount" field, which is the number of items returned by the cursor not the total number of items in the database
    /// * All LIST methods in the API return cursors and they all work the same way
    ///
    /// OPTIONAL PARAMETERS:
    /// * propertyid : Filters list of conversations by property. Exact match only, case sensitive.
    /// * cursor : (Optional, default = ""). For cusoring, pass in cursor output from previous call to continue where you left off.
    /// * limit : (Optional, default = 200). For cursoring, limit the number of responses for this request.
    ///
    /// Retrieves metadata about all conversations for a property. Whenever you create a conversation, you provide a property to associate it with. This returns the metadata for all conversations associated with a property.
    ///
    /// - Warning: This method requires authentication.
    public class ListConversationsWithFilters: ParametersBase<ListConversationsWithFilters.Fields,ListConversationsWithFilters>
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
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.ListConversationsWithFilters
        {
            set(dictionary: dictionary)
            let ret = ListConversationsWithFilters()
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
            return toDictionary
        }
    }
    
    /// DELETES a Conversation, all Comments and Replies
    ///
    /// CANNOT BE UNDONE. This deletes all history of a conversation including all comments and replies within it.
    ///
    /// * comment_conversation_id: (required) The ID of the comment conversation, URL ENCODED.
    /// CURSORING:
    ///
    /// - Warning: This method requires authentication.
    public class DeleteConversation: ParametersBase<DeleteConversation.Fields,DeleteConversation>
    {
        
        public enum Fields
        {
            case comment_conversation_id
        }
        
        public var comment_conversation_id: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.DeleteConversation
        {
            set(dictionary: dictionary)
            let ret = DeleteConversation()
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
    
    /// Creates a comment and publishes it
    ///
    /// You can optionally make this comment into a reply by passing in the optional replyto field. Custom fields can be set, and can be overwritten. However, once a custom field is used it can not be set to no value (empty string).
    ///
    /// URL ARGUMENTS:
    ///
    /// * comment_conversation_id : (required) The ID of the comment stream to publish the comment to. See the Create / Update Conversation method for rules around conversationid.
    ///
    /// BODY PROPERTIES:
    ///
    /// * userid : (required) The application's userid representing the user who submitted the comment
    /// * body : (required) The body of the comment (the message). Supports unicode characters including EMOJIs and international characters.
    /// * replyto : (optional) The ID of the comment that this is a reply to.
    ///
    ///
    /// - Warning: This method requires authentication.
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
    
    /// Creates a comment and publishes it
    ///
    /// This example emonstrates creating and publishing a comment and simultaneously creating a new user. See documentation for Create and Publish Comment.
    ///
    /// URL ARGUMENTS:
    ///
    /// * comment_conversation_id : (required) The ID of the comment stream to publish the comment to. See the Create / Update Conversation method for rules around conversationid.
    ///
    /// BODY PROPERTIES:
    ///
    /// * userid : (required) The application's userid representing the user who submitted the comment
    /// * body : (required) The body of the comment (the message). Supports unicode characters including EMOJIs and international characters.
    /// * replyto : (optional) The ID of the comment that this is a reply to.
    ///
    ///
    /// OPTIONAL BODY PROPERTIES TO CREATE OR UPDATE A USER:
    /// * handle: (Optional) If you are creating a user and you don't specify a handle, the system will generate one for you (using Display Name as basis if you provide that). If you request a handle and it's already in use a new handle will be generated for you and returned. Handle is an easy to type unique identifier for a user, for example @GeorgeWashington could be the handle but Display Name could be "da prez numero uno".
    ///
    /// * displayname: Optional. This is the desired name to display, typically the real name of the person.
    ///
    /// * pictureurl: Optional. The URL to the picture for this user.
    ///
    /// * profileurl: Optional. The profileurl for this user.
    ///
    /// * customid : (optional) 250 characters for a custom ID for your app. This field is indexed for high performance object retrieval.
    ///
    /// * customtype : (optional) Custom type string.
    ///
    /// * custompayload : (optional) Custom payload string.
    ///
    /// * customfield1 : (optional) User custom field 1. Store any string value you want here, limit 1024 bytes.
    ///
    /// * customfield2 : (optional) User custom field 2. Store any string value you want here, limit 1024 bytes.
    ///
    /// * customtags : (optional) A comma delimited list of tags
    ///
    /// - Warning: This method requires authentication.
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
            case customid
            case customtype
            case custompayload
            case customfield1
            case customfield2
            case customtags
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
        public var customid: String?
        public var customtype: String?
        public var custompayload: String?
        public var customfield1: String?
        public var customfield2: String?
        public var customtags: [String]?
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
            ret.customid = value(forKey: .customid)
            ret.customtype = value(forKey: .customtype)
            ret.custompayload = value(forKey: .custompayload)
            ret.customfield1 = value(forKey: .customfield1)
            ret.customfield2 = value(forKey: .customfield2)
            ret.customtags = value(forKey: .customtags)
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
            add(key: .customid, value: customid)
            add(key: .customtype, value: customtype)
            add(key: .custompayload, value: custompayload)
            add(key: .customfield1, value: customfield1)
            add(key: .customfield2, value: customfield2)
            add(key: .customtags, value: customtags)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            addRequired(key: .handle, value: handle)
            addRequired(key: .displayname, value: displayname)
            return toDictionary
        }
    }
    
    
    /// Creates a reply to a comment and publishes it
    ///
    /// The reply to comment method is the same as the create comment method, except you pass in the ID of the parent comment using the replyto field. See WEBHOOKS SERVICE API for information on receiving a notification when someone replies to a comment. See documentation on Create and Publish Comment
    ///
    /// URL ARGUMENTS:
    ///
    /// * comment_conversation_id : (required) The ID of the comment stream to publish the comment to. See the Create / Update Conversation method for rules around conversationid.
    /// * comment_comment_id : (required) The unique ID of the comment we will reply to.
    ///
    /// BODY PROPERTIES:
    ///
    /// * userid : (required) The application's userid representing the user who submitted the comment
    /// * body : (required) The body of the comment (the message). Supports unicode characters including EMOJIs and international characters.
    /// * replyto : (optional) The ID of the comment that this is a reply to.
    ///
    /// - Warning: This method requires authentication.
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
    
    
    /// Get a COMMENT by ID
    ///
    /// The comment time stamp is stored in UTC time.
    ///
    /// URL ARGUMENTS:
    ///
    /// * comment_conversation_id : (required) The ID of the comment stream to publish the comment to. See the Create / Update Conversation method for rules around conversationid.
    ///
    /// * comment_comment_id : (required) The unique ID of the comment we will reply to.
    ///
    /// - Warning: This method requires authentication.
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
    
    /// Get a list of comments within a conversation
    ///
    /// GETTING THE RIGHT COMMENTS
    ///
    /// *  If you use ListComments you will get the top level comments.
    /// *  If you use List Replies you will get comments that are children of another comment.
    /// *  If you want all replies lower in the tree of comments than the current level use the includechildren property.
    ///
    /// READ THIS: Cursoring Limitations for Offset Cursors
    ///
    /// If you use a cursoring method that is offset based (likes/votescore/mostreplies) rather than time based (oldest/newest) you are not guaranteed to see all of the comments. This is because the original query runs, and returs the comments ordered by your query. But, if you then send another request with a cursor value to get the next bunch, the cursor skips over the first set of results equal to the limit size in the query and returns the next set. So if you change your limit size or the underlying data changes because people react, vote, and like things, then you may not get a perfect results set. It is recommended that you request the top N records in one shot, as long as the request isn't too large. Otherwise, use cursoring with oldest sort method to download the entire list of comments and sort it yourself.
    ///
    /// CURSORING
    /// API Method returns a cursor
    /// *  Cursor includes a "more" field indicating if there are more results that can be read at the time this call is made
    /// *  Cursor includes "cursor" field, which can be passed into subsequent calls to this method to get additionaal results
    /// *  Cursor includes "itemcount" field, which is the number of items returned by the cursor not the total number of items in the database
    /// *  All LIST methods in the API return cursors and they all work the same way
    ///
    /// URL ARGUMENTS:
    /// *  comment_conversation_id : (required) The ID of the comment conversation, URL ENCODED.
    ///
    /// URL PARAMETERS
    /// * cursor : (optional) If provided, will get the next bundle of comments in the conversation resuming from where the cursor left off.
    /// * limit : (Optional, default = 200). For cursoring, limit the number of responses for this request.
    /// * direction: (optional) Default is forward. Must be forward or backward
    /// * sort : (optional, defaults to "oldest") Specifies that sort should be done by...
    ///
    ///         * oldest : Sort by when added ascending (oldest on top)
    ///         * newest : Sort by when added ascending (newest on top)
    ///         * likes : Sort by number of likes, descending (most liked on top)
    ///         * votescore : Sort by net of adding upvotes and subtracting downvotes, descending
    ///         * mostreplies : Sort by number of replies,descending
    ///         * includechildren : (optional, default is false) If false, this returns all reply nodes that are immediate children of the provided parent id. If true, it includes all replies under the parent id and all the children of those replies and so on.
    ///         * includeinactive : (optional, default is false) If true, return comments that are inactive (for example, disabled by moderation)
    ///
    /// - Warning: This method requires authentication.
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
    
    /// Get a list of replies to a comment
    ///
    /// This method works the same way as the List Comments method, so view the documentation on that method. The difference is that this method will filter to only include comments that have a parent.
    ///
    /// GETTING THE RIGHT COMMENTS
    ///
    /// *  If you use ListComments you will get the top level comments.
    /// *  If you use List Replies you will get comments that are children of another comment.
    /// *  If you want all replies lower in the tree of comments than the current level use the includechildren property.
    ///
    /// READ THIS: Cursoring Limitations for Offset Cursors
    ///
    /// If you use a cursoring method that is offset based (likes/votescore/mostreplies) rather than time based (oldest/newest) you are not guaranteed to see all of the comments. This is because the original query runs, and returs the comments ordered by your query. But, if you then send another request with a cursor value to get the next bunch, the cursor skips over the first set of results equal to the limit size in the query and returns the next set. So if you change your limit size or the underlying data changes because people react, vote, and like things, then you may not get a perfect results set. It is recommended that you request the top N records in one shot, as long as the request isn't too large. Otherwise, use cursoring with oldest sort method to download the entire list of comments and sort it yourself.
    ///
    /// CURSORING
    /// API Method returns a cursor
    /// *  Cursor includes a "more" field indicating if there are more results that can be read at the time this call is made
    /// *  Cursor includes "cursor" field, which can be passed into subsequent calls to this method to get additionaal results
    /// *  Cursor includes "itemcount" field, which is the number of items returned by the cursor not the total number of items in the database
    /// *  All LIST methods in the API return cursors and they all work the same way
    ///
    /// URL ARGUMENTS:
    /// *  comment_conversation_id : (required) The ID of the comment conversation, URL ENCODED.
    ///
    /// URL PARAMETERS
    /// * cursor : (optional) If provided, will get the next bundle of comments in the conversation resuming from where the cursor left off.
    /// * limit : (Optional, default = 200). For cursoring, limit the number of responses for this request.
    /// * direction: (optional) Default is forward. Must be forward or backward
    /// * sort : (optional, defaults to "oldest") Specifies that sort should be done by...
    ///
    ///         * oldest : Sort by when added ascending (oldest on top)
    ///         * newest : Sort by when added ascending (newest on top)
    ///         * likes : Sort by number of likes, descending (most liked on top)
    ///         * votescore : Sort by net of adding upvotes and subtracting downvotes, descending
    ///         * mostreplies : Sort by number of replies,descending
    ///         * includechildren : (optional, default is false) If false, this returns all reply nodes that are immediate children of the provided parent id. If true, it includes all replies under the parent id and all the children of those replies and so on.
    ///         * includeinactive : (optional, default is false) If true, return comments that are inactive (for example, disabled by moderation)
    ///
    /// - Warning: This method requires authentication.
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
            return toDictionary
        }
    }
    
    
    /// Set Deleted (LOGICAL DELETE)
    ///
    /// The comment is not actually deleted. The comment is flagged as deleted, and can no longer be read, but replies are not deleted.
    ///
    /// URL ARGUMENTS:
    ///
    /// *  comment_conversation_id : (required) The ID of the comment conversation, URL ENCODED.
    /// * comment_comment_id : (required) The unique ID of the comment, URL ENCODED.
    ///
    /// URL PARAMETERS
    ///
    /// * userid: (required) This is the application specific user ID of the user deleting the comment. Must be the owner of the comment or authorized moderator.
    ///
    /// * deleted : (required) Set to true or false to flag the comment as deleted. If a comment is deleted, then it will have the deleted field set to true, in which case the contents of the comment should not be shown and the body of the comment will not be returned by the API by default. If a previously deleted comment is undeleted, the flag for deleted is set to false and the original comment body is returned.
    ///
    /// * permanentifnoreplies: (optional) If this optional parameter is set to "true", then if this comment has no replies it will be permanently deleted instead of logically deleted. If a permanent delete is performed, the result will include the field "permanentdelete=true".
    ///
    /// If you want to mark a comment as deleted, and replies are still visible, use "true" for the logical delete value. If you want to permanently delete the comment and all of its replies, pass false.
    ///
    /// - Warning: This method requires authentication.
    public class FlagCommentAsDeleted: ParametersBase<FlagCommentAsDeleted.Fields,FlagCommentAsDeleted>
    {
        
        public enum Fields
        {
            case comment_conversation_id
            case comment_comment_id
            case userid
            case deleted
            case permanentifnoreplies
        }
        
        public var comment_conversation_id: String?
        public var comment_comment_id: String?
        public var userid: String?
        public var deleted: Bool? = true
        public var permanentifnoreplies: Bool?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentsService.FlagCommentAsDeleted
        {
            set(dictionary: dictionary)
            
            let ret = FlagCommentAsDeleted()
            ret.comment_conversation_id = value(forKey: .comment_conversation_id)
            ret.comment_comment_id = value(forKey: .comment_comment_id)
            ret.userid = value(forKey: .userid)
            ret.deleted = value(forKey: .deleted)
            ret.permanentifnoreplies = value(forKey: .permanentifnoreplies)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .comment_conversation_id, value: comment_conversation_id)
            add(key: .comment_comment_id, value: comment_comment_id)
            add(key: .userid, value: userid)
            add(key: .deleted, value: deleted)
            add(key: .permanentifnoreplies, value: permanentifnoreplies)
            
            addRequired(key: .comment_conversation_id, value: comment_conversation_id)
            addRequired(key: .comment_comment_id, value: comment_comment_id)
            
            return toDictionary
        }
    }
    
    
    /// DELETES a comment and all replies to that comment
    ///
    /// The comment is not actually deleted. The comment is flagged as deleted, and can no longer be read, but replies are not deleted.
    ///
    /// URL ARGUMENTS:
    ///
    /// *  comment_conversation_id : (required) The ID of the comment conversation, URL ENCODED.
    /// * comment_comment_id : (required) The unique ID of the comment, URL ENCODED.
    ///
    /// URL PARAMETERS
    ///
    /// * userid: (required) This is the application specific user ID of the user deleting the comment. Must be the owner of the comment or authorized moderator.
    ///
    /// - Warning: This method requires authentication.
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
    
    /// UPDATES the contents of an existing comment
    ///
    /// The comment is not actually deleted. The comment is flagged as deleted, and can no longer be read, but replies are not deleted.
    ///
    /// URL ARGUMENTS:
    ///
    /// *  comment_conversation_id : (required) The ID of the comment conversation, URL ENCODED.
    /// * comment_comment_id : (required) The unique ID of the comment, URL ENCODED.
    ///
    /// BODY PROPERTIES
    ///
    /// * userid : (required) The application specific user ID of the comment to be updated. This must be the owner of the comment or moderator / admin.
    /// * body : (required) The new body contents of the comment.
    ///
    /// - Warning: This method requires authentication.
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
    
    
    /// Adds or removes a reaction to a comment
    ///
    /// A reaction can be added using any reaction string that you wish.
    ///
    /// URL ARGUMENTS:
    ///
    /// *  comment_conversation_id : (required) The ID of the comment conversation, URL ENCODED.
    /// * comment_comment_id : (required) The unique ID of the comment, URL ENCODED.
    ///
    /// BODY PROPERTIES
    ///
    /// * userid : (required) The ID of the user reacting to the comment. Anonymous reactions are not supported.
    /// * reaction : (required) A string indicating the reaction you wish to capture.
    /// * reacted : (required) true or false, to toggle the reaction on or off for this user.
    ///
    /// - Warning: This method requires authentication.
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
   
    ///  UPVOTE, DOWNVOTE, or REMOVE VOTE
    ///
    /// A reaction can be added using any reaction string that you wish.
    ///
    /// URL ARGUMENTS:
    ///
    /// *  comment_conversation_id : (required) The ID of the comment conversation, URL ENCODED.
    /// * comment_comment_id : (required) The unique ID of the comment, URL ENCODED.
    ///
    /// BODY PROPERTIES
    ///
    /// * vote : (required) Must be one of "up", "down", or "none" (empty value). If up, the comment receives an upvote. If down, the comment receives a down vote. If empty, the vote is removed.
    /// * userid : (required) The application specific user id performing the action.
    ///
    /// - Warning: This method requires authentication.
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
    
    /// REPORTS a comment to the moderation team.
    ///
    /// URL ARGUMENTS:
    ///
    /// * comment_conversation_id : (required) The ID of the comment conversation, URL ENCODED.
    /// * comment_comment_id : (required) The unique ID of the comment, URL ENCODED.
    ///
    /// BODY PROPERTIES
    ///
    /// * reporttype : (required): e.g. abuse
    /// * userid : (required) The application specific user id performing the action.
    ///
    /// - Warning: This method requires authentication.
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
