import Foundation

public class CommentRequest {
    
    /// Creates a conversation (a context for comments)
    ///
    /// If a conversation with the specified ID already exists, this will update it.
    ///
    /// Custom fields can be set, and can be overwritten. However, once a custom field is used it can not be set to no value (empty string).
    ///
    /// PARAMETERS
    ///     conversationid : (required) The conversation ID. This must be a URL friendly string (cannot contain / ? or other URL delimiters). Maximum length is 250 characters.
    ///     property : (required) The property this conversation is associated with. It is any string value you want. Typically this is the domain of your website for which you want to use commenting, if you have more than one. Examples:
    ///         "dev", "uat", "stage", "prod"
    ///         "website", "mobile"
    ///         "site1.com", "site2.com"
    ///     moderation : (required) Specify if pre or post moderation is to be used
    ///     maxreports : (optional, default = 3) If this number of users flags a content item in this conversation, the item is disabled and sent to moderator queue for review
    ///     enableprofanityfilter: (optional) [default=true / false] Enables profanity filtering.
    ///     title : (optional) The title of the conversation
    ///     maxcommentlen: (optional) The maximum allowed length of a comment. Default is 256 characters. Maximum value is 10485760 (10 MB)
    ///     open: (optional, defaults to true) If the conversation is open people can add comments.
    ///     added: (optional) If this timestamp is provided then the whenadded field will be overridden. You should only use this when migrating data; data is timestamped automatically. Example value: "2020-05-02T08:51:53.8140055Z"
    ///     whenmodified: (optional)
    ///     customtype : (optional) Custom type string.
    ///     customid : (optional) 250 characters for a custom ID for your app. This field is indexed for high performance object retrieval.
    ///     customtags : (optional) A comma delimited list of tags
    ///     custompayload : (optional) Custom payload string.
    ///     customfield1 : (optional) User custom field 1. Store any string value you want here, limit 1024 bytes.
    ///     customfield2 : (optional) User custom field 2. Store any string value you want here, limit 1024 bytes.
    ///
    /// - Warning: This method requires authentication.
    public class CreateUpdateConversation: ParametersBase<CreateUpdateConversation.Fields,CreateUpdateConversation> {
        public enum Fields {
            // Body
            case conversationid
            case property
            case moderation
            case maxreports
            case enableprofanityfilter
            case title
            case maxcommentlen
            case open
            case added
            case whenmodified
            case customtype
            case customid
            case customtags
            case custompayload
            case customfield1
            case customfield2
        }
        
        public let conversationid: String   // REQUIRED
        public let property: String         // REQUIRED
        public let moderation: String       // REQUIRED
        public var maxreports: Int?
        public var enableprofanityfilter: Bool?
        public var title: String?
        public var maxcommentlen: Int64?
        public var open: Bool?
        public var added: String?   // OPTIONAL, Example value: "2020-05-02T08:51:53.8140055Z"
        public var whenmodified: String?   // OPTIONAL, Example value: "2020-05-02T08:51:53.8140055Z"
        public var customtype: String?
        public var customid: String?
        public var customtags: [String]?
        public var custompayload: String?
        public var customfield1: String?
        public var customfield2: String?
        
        public init(conversationid: String, property: String, moderation: String, maxreports: Int? = nil, enableprofanityfilter: Bool? = nil, title: String? = nil, maxcommentlen: Int64? = nil, open: Bool? = nil, added: String? = nil, whenmodified: String? = nil, customtype: String? = nil, customid: String? = nil, customtags: [String]? = nil, custompayload: String? = nil, customfield1: String? = nil, customfield2: String? = nil) {
            self.conversationid = conversationid
            self.property = property
            self.moderation = moderation
            self.maxreports = maxreports
            self.enableprofanityfilter = enableprofanityfilter
            self.title = title
            self.maxcommentlen = maxcommentlen
            self.open = open
            self.added = added
            self.whenmodified = whenmodified
            self.customtype = customtype
            self.customid = customid
            self.customtags = customtags
            self.custompayload = custompayload
            self.customfield1 = customfield1
            self.customfield2 = customfield2
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.CreateUpdateConversation {
            set(dictionary: dictionary)
            let ret = CreateUpdateConversation(
                conversationid: value(forKey: .conversationid) ?? "",
                property: value(forKey: .property) ?? "",
                moderation: value(forKey: .moderation) ?? ""
            )
            ret.maxreports = value(forKey: .maxreports)
            ret.enableprofanityfilter = value(forKey: .enableprofanityfilter)
            ret.title = value(forKey: .title)
            ret.maxcommentlen = value(forKey: .maxcommentlen)
            ret.open = value(forKey: .open)
            ret.added = value(forKey: .added)
            ret.whenmodified = value(forKey: .whenmodified)
            ret.customtype = value(forKey: .customtype)
            ret.customid = value(forKey: .customid)
            ret.customtags = value(forKey: .customtags)
            ret.custompayload = value(forKey: .custompayload)
            ret.customfield1 = value(forKey: .customfield1)
            ret.customfield2 = value(forKey: .customfield2)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .conversationid, value:  conversationid)
            addRequired(key: .property, value:  property)
            addRequired(key: .moderation, value:  moderation)
            add(key: .maxreports, value:  maxreports)
            add(key: .enableprofanityfilter, value:  enableprofanityfilter)
            add(key: .title, value:  title)
            add(key: .maxcommentlen, value:  maxcommentlen)
            add(key: .open, value:  open)
            add(key: .added, value:  added)
            add(key: .whenmodified, value:  whenmodified)
            add(key: .customtype, value:  customtype)
            add(key: .customid, value:  customid)
            add(key: .customtags, value:  customtags)
            add(key: .custompayload, value:  custompayload)
            add(key: .customfield1, value:  customfield1)
            add(key: .customfield2, value:  customfield2)
            
            return toDictionary
        }
    }
    
    ///
    /// Get Conversation by ID
    ///
    /// PARAMETERS
    ///     conversationid : (required) The ID of the conversation which is a context for comments. The ID must be URL ENCODED.
    ///
    /// - Warning: This method requires authentication.
    ///
    public class GetConversationById: ParametersBase<GetConversationById.Fields,GetConversationById> {
        public enum Fields
        {
            case conversationid
        }
        
        public let conversationid: String   // REQUIRED
        
        public init(conversationid: String) {
            self.conversationid = conversationid
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.GetConversationById {
            set(dictionary: dictionary)
            let ret = GetConversationById(
                conversationid: value(forKey: .conversationid) ?? ""
            )
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            return toDictionary
        }
    }
    
    /// Find Conversation by CustomID
    ///
    /// Uses the CustomID for the conversation supplied by the app to retrieve the conversation object. It returns exactly one object or 404 if not found. This query is covered by an index and is performant.
    ///
    /// PARAMETERS
    ///     customid : (Required) Locates a conversation using the custom ID.
    ///
    /// - Warning: This method requires authentication.
    ///
    public class FindConversationByIdCustomId: ParametersBase<FindConversationByIdCustomId.Fields,FindConversationByIdCustomId> {
        public enum Fields {
            case customid
        }
        
        public let customid: String     // REQUIRED
        public init(customid: String) {
            self.customid = customid
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.FindConversationByIdCustomId {
            set(dictionary: dictionary)
            let ret = FindConversationByIdCustomId(
                customid: value(forKey: .customid) ?? ""
            )
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .customid, value: customid)
            return toDictionary
        }
    }
    
    ///
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
    /// PARAMETERS
    ///     propertyid : Filters list of conversations by property. Exact match only, case sensitive.
    ///     cursor : (Optional, default = ""). For cusoring, pass in cursor output from previous call to continue where you left off.
    ///     limit : (Optional, default = 200). For cursoring, limit the number of responses for this request.
    ///     sort : (optional, defaults to "oldest") Specifies that sort should be done by...
    ///         oldest : Sort by when added ascending (oldest on top)
    ///         newest : Sort by when added ascending (newest on top)
    ///         likes : Sort by number of likes, descending (most liked on top)
    ///         votescore : Sort by net of adding upvotes and subtracting downvotes, descending
    ///         mostreplies : Sort by number of replies,descending
    ///
    /// Retrieves metadata about all conversations for a property. Whenever you create a conversation, you provide a property to associate it with. This returns the metadata for all conversations associated with a property.
    ///
    /// - Warning: This method requires authentication.
    ///
    public class ListConversations: ParametersBase<ListConversations.Fields,ListConversations> {
        public enum Fields {
            // Query Params
            case propertyid
            case cursor
            case limit
            case sort
        }
        
        public var propertyid: String?
        public var cursor: String?
        public var limit: Int?
        public var sort: SortType?
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.ListConversations {
            set(dictionary: dictionary)
            let ret = ListConversations()
            ret.propertyid = value(forKey: .propertyid)
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            if let sortStr: String = value(forKey: .sort) {
                ret.sort = SortType(rawValue: sortStr)
            }
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            add(key: .propertyid, value: propertyid)
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            add(key: .sort, value: sort)
            return toDictionary
        }
    }
    
    ///
    /// Batch Get Conversation Details
    ///
    /// The purpose of this method is to support a use case where you start with a list of conversations and you want metadata about only those conversations so you can display things like like count or comment count making minimal requests.
    ///
    /// You can choose to either retrieve articles using the sportstalk ID or by using your custom IDs you associated with the conversation using our create/update conversation API.
    ///
    /// PARAMETERS
    ///     ids: (optional): Include one or more comma delimited Sportstalk conversation IDs.
    ///     cid: (optional): Include one or more cid arguments. Each is a URL ENCODED string containing the customid. You can specify up to 200 at a time.
    ///     entities (optional): By default only the conversation object data is returned. For more data (and deeper queries) provide any of these entities:
    ///         reactions: Includes user reactions and microprofiles in the response
    ///         likecount: Includes number of likes on the conversation in the response, otherwise returns -1 for like count.
    ///         commentcount: Includes the number of comments in the response, otherwise returns -1 for comment count.
    ///
    public class GetBatchConversationDetails: ParametersBase<GetBatchConversationDetails.Fields, GetBatchConversationDetails> {
        
        public enum Fields {
            // Query Params
            case ids
            case cid
            case entities
        }
        
        public var ids: [String]?
        public var cid: [String]?
        public var entities: [BatchGetConversationEntity]?
        
        public init(ids: [String]? = nil, cid: [String]? = nil, entities: [BatchGetConversationEntity]? = nil) {
            self.ids = ids
            self.cid = cid
            self.entities = entities
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.GetBatchConversationDetails {
            set(dictionary: dictionary)
            
            let idsStr = value(forKey: .ids) ?? ""
            let entitiesStr: [String] = value(forKey: .entities) ?? []
            
            let ret = GetBatchConversationDetails(
                ids: idsStr.split(separator: ",").map { String($0) },
                cid: value(forKey: .cid),
                entities: entitiesStr.map { BatchGetConversationEntity(rawValue: $0)! }
            )
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            if let ids {
                let csvValue = ids.joined(separator: ",")
                add(key: .ids, value: csvValue)
            }
            
            if let cid {
                add(key: .cid, value: cid)
            }
            
            if let entities {
                add(key: .entities, value: entities.map { $0.rawValue })
            }
            
            return toDictionary
        }
        
    }
    
    ///
    /// Adds or removes a reaction to a topic
    ///
    /// A conversation context is mapped to your topic by using either the conversationid or the customid. You can either react to the content itself (for example to LIKE an article/video/poll) or you can use the comment react api to react to an individual comment. This method is for commenting on the conversation topic level.
    ///
    /// PARAMETERS
    ///    userid : (required) The ID of the user reacting to the comment. Anonymous reactions are not supported.
    ///    reaction : (required) A string indicating the reaction you wish to capture, for example "like", or "emoji:{id}" where you can use the standard character code for your emoji.
    ///    reacted : (required) true or false, to toggle the reaction on or off for this user.
    ///
    public class ReactToConversationTopic: ParametersBase<ReactToConversationTopic.Fields, ReactToConversationTopic> {
        
        public enum Fields {
            // Path
            case conversationid
            
            // Body
            case userid
            case reaction
            case reacted
        }
        
        public let conversationid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public let reaction: String // REQUIRED
        public let reacted: Bool    // REQUIRED
        
        public init(conversationid: String, userid: String, reaction: String, reacted: Bool) {
            self.conversationid = conversationid
            self.userid = userid
            self.reaction = reaction
            self.reacted = reacted
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> ReactToConversationTopic {
            set(dictionary: dictionary)
            
            let ret = ReactToConversationTopic(
                conversationid: value(forKey: .conversationid) ?? "",
                userid: value(forKey: .userid) ?? "",
                reaction: value(forKey: .reaction) ?? "",
                reacted: value(forKey: .reacted) ?? false
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .userid, value: userid)
            addRequired(key: .reaction, value: reaction)
            addRequired(key: .reacted, value: reacted)
            
            return toDictionary
        }
        
    }
    
    ///
    /// Creates a comment and publishes it
    ///
    /// You can optionally make this comment into a reply by passing in the optional replyto field. Custom fields can be set, and can be overwritten. However, once a custom field is used it can not be set to no value (empty string).
    
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment stream to publish the comment to. See the Create / Update Conversation method for rules around conversationid.
    ///    userid : (required) The application's userid representing the user who submitted the comment
    ///    displayname: Optional. This is the desired name to display, typically the real name of the person.
    ///    body : (required) The body of the comment (the message). Supports unicode characters including EMOJIs and international characters.
    ///    customtype : (optional) Custom type string.
    ///    customfield1 : (optional) User custom field 1. Store any string value you want here, limit 1024 bytes.
    ///    customfield2 : (optional) User custom field 2. Store any string value you want here, limit 1024 bytes.
    ///    customtags : (optional) A comma delimited list of tags
    ///    custompayload : (optional) Custom payload string.
    ///
    public class CreateComment: ParametersBase<CreateComment.Fields, CreateComment> {
        public enum Fields {
            // Path
            case conversationid
            
            // Body
            case userid
            case displayname
            case body
            case customtype
            case customfield1
            case customfield2
            case customtags
            case custompayload
        }
        
        public let conversationid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public var displayname: String?
        public let body: String     // REQUIRED
        public var customtype: String?
        public var customfield1: String?
        public var customfield2: String?
        public var customtags: [String]?
        public var custompayload: String?
        
        public init(conversationid: String, userid: String, displayname: String? = nil, body: String, customtype: String? = nil, customfield1: String? = nil, customfield2: String? = nil, customtags: [String]? = nil, custompayload: String? = nil) {
            self.conversationid = conversationid
            self.userid = userid
            self.displayname = displayname
            self.body = body
            self.customtype = customtype
            self.customfield1 = customfield1
            self.customfield2 = customfield2
            self.customtags = customtags
            self.custompayload = custompayload
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.CreateComment {
            set(dictionary: dictionary)
            
            let ret = CreateComment(
                conversationid: value(forKey: .conversationid) ?? "",
                userid: value(forKey: .userid) ?? "",
                body: value(forKey: .body) ?? ""
            )
            ret.displayname = value(forKey: .displayname)
            ret.customtype = value(forKey: .customtype)
            ret.customfield1 = value(forKey: .customfield1)
            ret.customfield2 = value(forKey: .customfield2)
            ret.customtags = value(forKey: .customtags)
            ret.custompayload = value(forKey: .custompayload)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            add(key: .displayname, value: displayname)
            add(key: .customtype, value: customtype)
            add(key: .customfield1, value: customfield1)
            add(key: .customfield2, value: customfield2)
            add(key: .customtags, value: customtags)
            add(key: .custompayload, value: custompayload)
            
            return toDictionary
        }
        
    }
    
    ///
    /// Creates a reply to a comment and publishes it
    ///
    /// The reply to comment method is the same as the create comment method, except you pass in the ID of the parent comment using the replyto field. See WEBHOOKS SERVICE API for information on receiving a notification when someone replies to a comment. See documentation on Create and Publish Comment
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation.
    ///    replytocommentid : (required) The unique ID of the comment we will reply to.
    ///    userid : (required) The application's userid representing the user who submitted the comment
    ///    body : (required) The body of the reply (what the user is saying). Supports unicode characters including EMOJIs and international characters.
    ///    displayname: Optional. This is the desired name to display, typically the real name of the person.
    ///    customtype : (optional) Custom type string.
    ///    customfield1 : (optional) User custom field 1. Store any string value you want here, limit 1024 bytes.
    ///    customfield2 : (optional) User custom field 2. Store any string value you want here, limit 1024 bytes.
    ///    customtags : (optional) A comma delimited list of tags
    ///    custompayload : (optional) Custom payload string.
    ///
    public class ReplyToComment: ParametersBase<CommentRequest.ReplyToComment.Fields, CommentRequest.ReplyToComment> {
        public enum Fields {
            // Path
            case conversationid
            case replytocommentid
            
            // Body
            case userid
            case displayname
            case body
            case customtype
            case customfield1
            case customfield2
            case customtags
            case custompayload
        }
        
        public let conversationid: String   // REQUIRED
        public let replytocommentid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public var displayname: String?
        public let body: String     // REQUIRED
        public var customtype: String?
        public var customfield1: String?
        public var customfield2: String?
        public var customtags: [String]?
        public var custompayload: String?
        
        public init(conversationid: String, replytocommentid: String, userid: String, displayname: String? = nil, body: String, customtype: String? = nil, customfield1: String? = nil, customfield2: String? = nil, customtags: [String]? = nil, custompayload: String? = nil) {
            self.conversationid = conversationid
            self.replytocommentid = replytocommentid
            self.userid = userid
            self.displayname = displayname
            self.body = body
            self.customtype = customtype
            self.customfield1 = customfield1
            self.customfield2 = customfield2
            self.customtags = customtags
            self.custompayload = custompayload
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.ReplyToComment {
            set(dictionary: dictionary)
            
            let ret = ReplyToComment(
                conversationid: value(forKey: .conversationid) ?? "",
                replytocommentid: value(forKey: .replytocommentid) ?? "",
                userid: value(forKey: .userid) ?? "",
                body: value(forKey: .body) ?? ""
            )
            ret.displayname = value(forKey: .displayname)
            ret.customtype = value(forKey: .customtype)
            ret.customfield1 = value(forKey: .customfield1)
            ret.customfield2 = value(forKey: .customfield2)
            ret.customtags = value(forKey: .customtags)
            ret.custompayload = value(forKey: .custompayload)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            add(key: .displayname, value: displayname)
            add(key: .customtype, value: customtype)
            add(key: .customfield1, value: customfield1)
            add(key: .customfield2, value: customfield2)
            add(key: .customtags, value: customtags)
            add(key: .custompayload, value: custompayload)
            
            return toDictionary
        }
    }
    
    ///
    /// Get a list of replies to a comment
    ///
    /// This method works the same way as the List Comments method, so view the documentation on that method. The difference is that this method will filter to only include comments that have a parent.
    ///
    /// ABOUT CURSORING
    ///    API Method returns a cursor
    ///    Cursor includes a "more" field indicating if there are more results that can be read at the time this call is made
    ///    Cursor includes "cursor" field, which can be passed into subsequent calls to this method to get additionaal results
    ///    Cursor includes "itemcount" field, which is the number of items returned by the cursor not the total number of items in the database
    ///    All LIST methods in the API return cursors and they all work the same way
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    cursor : (optional) If provided, will get the next bundle of comments in the conversation resuming from where the cursor left off.
    ///    limit : (Optional, default = 200). For cursoring, limit the number of responses for this request.
    ///    direction: (optional) Default is forward. Must be forward or backward
    ///    sort : (optional, defaults to "oldest") Specifies that sort should be done by...
    ///         oldest : Sort by when added ascending (oldest on top)
    ///         newest : Sort by when added ascending (newest on top)
    ///         likes : Sort by number of likes, descending (most liked on top)
    ///         votescore : Sort by net of adding upvotes and subtracting downvotes, descending
    ///         mostreplies : Sort by number of replies,descending
    ///    includechildren : (optional, default is false) If false, this returns all reply nodes that are immediate children of the provided parent id. If true, it includes all                replies under the parent id and all the children of those replies and so on.
    ///    includeinactive : (optional, default is false) If true, return comments that are inactive (for example, disabled by moderation)
    ///
    
    public class ListCommentReplies: ParametersBase<CommentRequest.ListCommentReplies.Fields, CommentRequest.ListCommentReplies> {
        public enum Fields {
            // Path
            case conversationid
            case commentid
            
            // Query Params
            case cursor
            case limit
            case direction
            case sort
            case includechildren
            case includeinactive
        }
        
        public let conversationid: String   // REQUIRED
        public let commentid: String    // REQUIRED
        public var cursor: String?
        public var limit: Int?
        public var direction: Ordering?
        public var sort: SortType?
        public var includechildren: Bool?
        public var includeinactive: Bool?
        
        public init(conversationid: String, commentid: String, cursor: String? = nil, limit: Int? = nil, direction: Ordering? = nil, sort: SortType? = nil, includechildren: Bool? = nil, includeinactive: Bool? = nil) {
            self.conversationid = conversationid
            self.commentid = commentid
            self.cursor = cursor
            self.limit = limit
            self.direction = direction
            self.sort = sort
            self.includechildren = includechildren
            self.includeinactive = includeinactive
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.ListCommentReplies {
            set(dictionary: dictionary)
            
            let ret = ListCommentReplies(
                conversationid: value(forKey: .conversationid) ?? "",
                commentid: value(forKey: .commentid) ?? ""
            )
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            if let directionStr: String = value(forKey: .direction) {
                ret.direction = Ordering(rawValue: directionStr)
            }
            if let sortStr: String = value(forKey: .sort) {
                ret.sort = SortType(rawValue: sortStr)
            }
            ret.includechildren = value(forKey: .includechildren)
            ret.includeinactive = value(forKey: .includeinactive)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            if let direction {
                add(key: .direction, value: direction.rawValue)
            }
            if let sort {
                add(key: .sort, value: sort.rawValue)
            }
            add(key: .includechildren, value: includechildren)
            add(key: .includeinactive, value: includeinactive)
            
            return toDictionary
        }
    }
    
    ///
    /// Get a COMMENT by ID
    ///
    /// The comment time stamp is stored in UTC time.
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    commentid : (required) The unique ID of the comment, URL ENCODED.*
    ///
    public class GetCommentDetails: ParametersBase<GetCommentDetails.Fields, GetCommentDetails> {
        public enum Fields {
            // Path
            case conversationid
            case commentid
        }
        
        public let conversationid: String   // REQUIRED
        public let commentid: String    // REQUIRED
        
        public init(conversationid: String, commentid: String) {
            self.conversationid = conversationid
            self.commentid = commentid
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.GetCommentDetails {
            set(dictionary: dictionary)
            
            let ret = GetCommentDetails(
                conversationid: value(forKey: .conversationid) ?? "",
                commentid: value(forKey: .commentid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            return toDictionary
        }
    }
    
    ///
    /// Get a list of comments within a conversation
    ///
    /// ABOUT CURSORING
    ///    API Method returns a cursor
    ///    Cursor includes a "more" field indicating if there are more results that can be read at the time this call is made
    ///    Cursor includes "cursor" field, which can be passed into subsequent calls to this method to get additionaal results
    ///    Cursor includes "itemcount" field, which is the number of items returned by the cursor not the total number of items in the database
    ///    All LIST methods in the API return cursors and they all work the same way
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    cursor : (optional) If provided, will get the next bundle of comments in the conversation resuming from where the cursor left off.
    ///    limit : (Optional, default = 200). For cursoring, limit the number of responses for this request.
    ///    direction: (optional) Default is forward. Must be forward or backward
    ///    sort : (optional, defaults to "oldest") Specifies that sort should be done by...
    ///         oldest : Sort by when added ascending (oldest on top)
    ///         newest : Sort by when added ascending (newest on top)
    ///         likes : Sort by number of likes, descending (most liked on top)
    ///         votescore : Sort by net of adding upvotes and subtracting downvotes, descending
    ///         mostreplies : Sort by number of replies,descending
    ///    includechildren : (optional, default is false) If false, this returns all reply nodes that are immediate children of the provided parent id. If true, it includes all                replies under the parent id and all the children of those replies and so on.
    ///    includeinactive : (optional, default is false) If true, return comments that are inactive (for example, disabled by moderation)
    ///
    public class ListComments: ParametersBase<ListComments.Fields, ListComments> {
        public enum Fields {
            // Path
            case conversationid
            
            // Query Params
            case cursor
            case limit
            case direction
            case sort
            case includechildren
            case includeinactive
        }
        
        public let conversationid: String   // REQUIRED
        public var cursor: String?
        public var limit: Int?
        public var direction: Ordering?
        public var sort: SortType?
        public var includechildren: Bool?
        public var includeinactive: Bool?
        
        public init(conversationid: String, cursor: String? = nil, limit: Int? = nil, direction: Ordering? = nil, sort: SortType? = nil, includechildren: Bool? = nil, includeinactive: Bool? = nil) {
            self.conversationid = conversationid
            self.cursor = cursor
            self.limit = limit
            self.direction = direction
            self.sort = sort
            self.includechildren = includechildren
            self.includeinactive = includeinactive
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> CommentRequest.ListComments {
            set(dictionary: dictionary)
            
            let ret = ListComments(
                conversationid: value(forKey: .conversationid) ?? ""
            )
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            if let directionStr: String = value(forKey: .direction) {
                ret.direction = Ordering(rawValue: directionStr)
            }
            if let sortStr: String = value(forKey: .sort) {
                ret.sort = SortType(rawValue: sortStr)
            }
            ret.includechildren = value(forKey: .includechildren)
            ret.includeinactive = value(forKey: .includeinactive)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            if let direction {
                add(key: .direction, value: direction.rawValue)
            }
            if let sort {
                add(key: .sort, value: sort.rawValue)
            }
            add(key: .includechildren, value: includechildren)
            add(key: .includeinactive, value: includeinactive)
            
            return toDictionary
        }
    }
    
    ///
    /// Get a list of replies to multiple parent Comments
    ///
    /// The purpose of this method is to support a use case where you open an app or website widget and you have just displayed up to N top level comments and you want to retrieve the replies to those comments quickly, in 1 request. You could call GetReplies for each top level parent, but if you want to get them in just one request use this method, which has more speed but some limitations:
    ///
    ///    This method does not support cursoring.
    ///    This method allows you to specify the maximum number of children to return per top level parent, but it does not apply a limit across the total number of replies across all of the top level comments.
    ///    This method will always return replies sorted by when originally published timestamp ascending (oldest to newest), with replies grouped by each parent comment in the result set.
    ///    This method will return the children that are direct immediate child replies to the parent only, not an entire tree under a parent.
    ///    If the parentid list contains a parentid that does not exist or has no child replies it will be skipped, you will not receive 404 unless none of the parentids were found.
    /// 
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    childlimit : (Optional, default = 50).
    ///    parentids : (Required). A list of parent comment ID(s), up to 30.
    ///    includeinactive : (optional, default is false) If true, return comments that are inactive (for example, disabled by moderation)
    ///
    public class GetBatchCommentReplies: ParametersBase<GetBatchCommentReplies.Fields, GetBatchCommentReplies> {
        public enum Fields {
            // Path
            case conversationid
            
            // Query Params
            case childlimit
            case parentids
            case includeinactive
        }
        
        public let conversationid: String   // REQUIRED
        public var childlimit: Int?
        public let parentids: [String]  // REQUIRED
        public var includeinactive: Bool?
        
        public init(conversationid: String, childlimit: Int? = nil, parentids: [String], includeinactive: Bool? = nil) {
            self.conversationid = conversationid
            self.childlimit = childlimit
            self.parentids = parentids
            self.includeinactive = includeinactive
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> GetBatchCommentReplies {
            set(dictionary: dictionary)
            let parentIds = (value(forKey: .parentids) ?? "").split(separator: ",").map { String($0) }
            
            let ret = GetBatchCommentReplies(
                conversationid: value(forKey: .conversationid) ?? "",
                parentids: parentIds
            )
            ret.childlimit = value(forKey: .childlimit)
            ret.includeinactive = value(forKey: .includeinactive)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            if let childlimit {
                add(key: .childlimit, value: childlimit)
            }
            
            add(key: .parentids, value: parentids.joined(separator: ","))
            
            if let includeinactive {
                add(key: .includeinactive, value: includeinactive)
            }
            
            return toDictionary
        }
    }
    
    ///
    /// Adds or removes a reaction to a comment
    ///
    /// A reaction can be added using any reaction string that you wish.
    ///
    /// PARAMETERS
    ///     conversationid : (required) The ID of the comment conversation.
    ///     commentid : (required) The unique ID of the comment we will reply to.
    ///     userid : (required) The ID of the user reacting to the comment. Anonymous reactions are not supported.
    ///     reaction : (required) A string indicating the reaction you wish to capture, for example "like", or "emoji:{id}" where you can use the standard character code for your emoji.
    ///     reacted : (required) true or false, to toggle the reaction on or off for this user.
    ///
    public class ReactToComment: ParametersBase<ReactToComment.Fields, ReactToComment> {
        public enum Fields {
            // Path
            case conversationid
            case commentid
            
            // Body
            case userid
            case reaction
            case reacted
        }
        
        public let conversationid: String   // REQUIRED
        public let commentid: String    // REQUIRED
        public let userid: String   // REQUIRED
        public let reaction: String // REQUIRED
        public let reacted: Bool    // REQUIRED
        
        public init(conversationid: String, commentid: String, userid: String, reaction: String, reacted: Bool) {
            self.conversationid = conversationid
            self.commentid = commentid
            self.userid = userid
            self.reaction = reaction
            self.reacted = reacted
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> ReactToComment {
            set(dictionary: dictionary)
            
            let ret = ReactToComment(
                conversationid: value(forKey: .conversationid) ?? "",
                commentid: value(forKey: .commentid) ?? "",
                userid: value(forKey: .userid) ?? "",
                reaction: value(forKey: .reaction) ?? "",
                reacted: value(forKey: .reacted) ?? false
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .conversationid, value: conversationid)
            addRequired(key: .commentid, value: commentid)
            addRequired(key: .userid, value: userid)
            addRequired(key: .reaction, value: reaction)
            addRequired(key: .reacted, value: reacted)
            
            return toDictionary
        }
    }
    
    ///
    /// UPVOTE, DOWNVOTE, or REMOVE VOTE
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    commentid : (required) The unique ID of the comment, URL ENCODED.
    ///    vote : (required) Must be one of "up", "down", or "none" (empty value). If up, the comment receives an upvote. If down, the comment receives a down vote. If empty, the vote is removed.
    ///    userid : (required) The application specific user id performing the action.
    ///
    public class VoteOnComment: ParametersBase<VoteOnComment.Fields, VoteOnComment> {
        public enum Fields {
            // Path
            case conversationid
            case commentid
            // Body
            case vote
            case userid
        }
        
        public let conversationid: String   // REQUIRED
        public let commentid: String    // REQUIRED
        public let vote: VoteType   // REQUIRED
        public let userid: String   // REQUIRED
        
        public init(conversationid: String, commentid: String, vote: VoteType, userid: String) {
            self.conversationid = conversationid
            self.commentid = commentid
            self.vote = vote
            self.userid = userid
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> VoteOnComment {
            set(dictionary: dictionary)
            
            let ret = VoteOnComment(
                conversationid: value(forKey: .conversationid) ?? "",
                commentid: value(forKey: .commentid) ?? "",
                vote: VoteType(rawValue: value(forKey: .vote) ?? "") ?? .none,
                userid: value(forKey: .userid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .vote, value: vote.rawValue)
            addRequired(key: .userid, value: userid)
            return toDictionary
        }
        
    }
    
    ///
    /// REPORTS a comment to the moderation team.
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    commentid : (required) The unique ID of the comment, URL ENCODED.
    ///    userid : (required) This is the application specific user ID of the user reporting the comment.
    ///    reporttype : (required) A string indicating the reason you wish to report(i.e. "abuse", "spam").
    ///
    public class ReportComment: ParametersBase<ReportComment.Fields, ReportComment> {
        public enum Fields {
            // Path
            case conversationid
            case commentid
            
            // Body
            case userid
            case reporttype
        }
        
        public let conversationid: String   // REQUIRED
        public let commentid: String    // REQUIRED
        public let userid: String   // REQUIRED
        public let reporttype: ReportType   // REQUIRED
        
        public init(conversationid: String, commentid: String, userid: String, reporttype: ReportType) {
            self.conversationid = conversationid
            self.commentid = commentid
            self.userid = userid
            self.reporttype = reporttype
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> ReportComment {
            set(dictionary: dictionary)
            
            let ret = ReportComment(
                conversationid: value(forKey: .conversationid) ?? "",
                commentid: value(forKey: .commentid) ?? "",
                userid: value(forKey: .userid) ?? "",
                reporttype: ReportType(rawValue: value(forKey: .reporttype) ?? "") ?? .abuse
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .userid, value: userid)
            addRequired(key: .reporttype, value: reporttype.rawValue)
            return toDictionary
        }
    }
    
    ///
    /// UPDATES the contents of an existing comment
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    commentid : (required) The unique ID of the comment, URL ENCODED.
    ///    userid : (required) The application specific user ID of the comment to be updated. This must be the owner of the comment or moderator / admin.
    ///    body : (required) The new body contents of the comment.
    ///
    ///    The comment will be flagged to indicate that it has been modified.
    ///
    public class UpdateComment: ParametersBase<UpdateComment.Fields, UpdateComment> {
        public enum Fields {
            // Path
            case conversationid
            case commentid
            
            // Body
            case userid
            case body
        }
        
        public let conversationid: String   // REQUIRED
        public let commentid: String    // REQUIRED
        public let userid: String   // REQUIRED
        public let body: String    // REQUIRED
        
        public init(conversationid: String, commentid: String, userid: String, body: String) {
            self.conversationid = conversationid
            self.commentid = commentid
            self.userid = userid
            self.body = body
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> UpdateComment {
            set(dictionary: dictionary)
            
            let ret = UpdateComment(
                conversationid: value(forKey: .conversationid) ?? "",
                commentid: value(forKey: .commentid) ?? "",
                userid: value(forKey: .userid) ?? "",
                body: value(forKey: .body) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            return toDictionary
        }
    }
    
    ///
    /// Set Deleted (LOGICAL DELETE)
    ///
    ///    The comment is not actually deleted. The comment is flagged as deleted, and can no longer be read, but replies are not deleted.
    ///    If flag "permanentifnoreplies" is true, then it will be a permanent delete instead of logical delete for this comment if it has no children.
    ///    If you use "permanentifnoreplies" = true, and this comment has a parent that has been logically deleted, and this is the only child, then the parent will also be permanently deleted.
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    commentid : (required) The unique ID of the comment, URL ENCODED.
    ///    userid : (required) This is the application specific user ID of the user deleting the comment. Must be the owner of the comment or authorized moderator.
    ///    deleted : (required) Set to true or false to flag the comment as deleted. If a comment is deleted, then it will have the deleted field set to true, in which case the contents of the comment should not be shown and the body of the comment will not be returned by the API by default. If a previously deleted                     comment is undeleted, the flag for deleted is set to false and the original comment body is returned.
    ///    permanentifnoreplies: (optional) If this optional parameter is set to "true", then if this comment has no replies it will be permanently deleted instead of logically deleted. If a permanent delete is performed, the result will include the field "permanentdelete=true".
    ///      If you want to mark a comment as deleted, and replies are still visible, use "true" for the logical delete value. If you want to permanently delete the comment and all of its replies, pass false.
    ///
    public class FlagCommentLogicallyDeleted: ParametersBase<FlagCommentLogicallyDeleted.Fields, FlagCommentLogicallyDeleted> {
        public enum Fields {
            // Path
            case conversationid
            case commentid
            
            // Query Params
            case userid
            case deleted
            case permanentifnoreplies
        }
        
        public let conversationid: String   // REQUIRED
        public let commentid: String    // REQUIRED
        public let userid: String   // REQUIRED
        public let deleted: Bool    // REQUIRED
        public var permanentifnoreplies: Bool?
        
        public init(conversationid: String, commentid: String, userid: String, deleted: Bool, permanentifnoreplies: Bool? = nil) {
            self.conversationid = conversationid
            self.commentid = commentid
            self.userid = userid
            self.deleted = deleted
            self.permanentifnoreplies = permanentifnoreplies
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> FlagCommentLogicallyDeleted {
            set(dictionary: dictionary)
            
            let ret = FlagCommentLogicallyDeleted(
                conversationid: value(forKey: .conversationid) ?? "",
                commentid: value(forKey: .commentid) ?? "",
                userid: value(forKey: .userid) ?? "",
                deleted: value(forKey: .deleted) ?? false
            )
            ret.permanentifnoreplies = value(forKey: .permanentifnoreplies)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .userid, value: userid)
            addRequired(key: .deleted, value: deleted)
            add(key: .permanentifnoreplies, value: permanentifnoreplies)
            return toDictionary
        }
    }
    
    ///
    /// DELETES a comment and all replies to that comment
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///    commentid : (required) The unique ID of the comment, URL ENCODED.
    ///
    public class PermanentlyDeleteComment: ParametersBase<PermanentlyDeleteComment.Fields, PermanentlyDeleteComment> {
        public enum Fields {
            // Path
            case conversationid
            case commentid
        }
        
        public let conversationid: String   // REQUIRED
        public let commentid: String    // REQUIRED
        
        public init(conversationid: String, commentid: String) {
            self.conversationid = conversationid
            self.commentid = commentid
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> PermanentlyDeleteComment {
            set(dictionary: dictionary)
            
            let ret = PermanentlyDeleteComment(
                conversationid: value(forKey: .conversationid) ?? "",
                commentid: value(forKey: .commentid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            return toDictionary
        }
    }
    
    ///
    /// DELETES a Conversation, all Comments and Replies
    ///
    ///    CANNOT BE UNDONE. This deletes all history of a conversation including all comments and replies within it.
    ///
    /// PARAMETERS
    ///    conversationid : (required) The ID of the comment conversation, URL ENCODED.
    ///
    public class DeleteConversation: ParametersBase<DeleteConversation.Fields, DeleteConversation> {
        public enum Fields {
            // Path
            case conversationid
        }
        
        public let conversationid: String   // REQUIRED
        
        public init(conversationid: String) {
            self.conversationid = conversationid
        }
        
        override func from(dictionary: [AnyHashable : Any]) -> DeleteConversation {
            set(dictionary: dictionary)
            
            let ret = DeleteConversation(
                conversationid: value(forKey: .conversationid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            return toDictionary
        }
    }
    
}
