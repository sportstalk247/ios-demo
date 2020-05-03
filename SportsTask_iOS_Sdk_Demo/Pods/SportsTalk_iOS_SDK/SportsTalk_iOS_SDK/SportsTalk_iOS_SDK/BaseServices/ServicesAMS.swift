import Foundation

public protocol ServicesAMSProtocol
{
    var authToken: String?
    {
        get set
    }
    
    var url: URL?
    {
        get set
    }
    
    var appId: String?{
        get set
    }
    
    var debug: Bool{
        get set
    }
    
    var services: Services { get }
    var user: Services.User? { get set }
//    Users
    func usersServices(_ request: UsersServices.CreateUpdateUser, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.DeleteUser, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.GetUserDetails, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.ListUsers, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.ListUsersMore, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.BanUser, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.RestoreUser, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.SearchUsersByHandle, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.SearchUsersByName, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.SearchUsersByUserId, completionHandler: @escaping CompletionHandler)
    
//     Chat
    func chatRoomsServices(_ request: ChatRoomsServices.CreateRoomPostmoderated , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.CreateRoomPremoderated , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.GetRoomDetails , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.DeleteRoom , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.UpdateRoom , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.UpdateRoomCloseARoom , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ListRooms , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.JoinRoomAuthenticatedUser , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.JoinRoomAnonymousUser , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ListRoomParticipants , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ExitRoom , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.GetUpdates , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.GetUpdatesMore , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ExecuteChatCommand , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ExecuteDanceAction , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ReplyToAMessage , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ListMessagesByUser , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.RemoveMessage , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.PurgeUserMessages , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ReportMessage , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ReactToAMessageLike , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ExecuteAdminCommand , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.DeleteAllEventsInRoom , completionHandler: @escaping CompletionHandler)
    
    // Moderation
    func moderationServices(_ request: ModerationServices.ApproveMessage , completionHandler: @escaping CompletionHandler)
    func moderationServices(_ request: ModerationServices.ListMessagesNeedingModeration , completionHandler: @escaping CompletionHandler)
    func moderationServices(_ request: ModerationServices.ApproveCommentInQueue , completionHandler: @escaping CompletionHandler)
    func moderationServices(_ request: ModerationServices.RejectCommentInQueue , completionHandler: @escaping CompletionHandler)
    func moderationServices(_ request: ModerationServices.ListCommentsInModerationQueue , completionHandler: @escaping CompletionHandler)
    
//    WebHook
    func webhooksServices(_ request: WebhooksServices.CreateReplaceWebhook, completionHandler: @escaping CompletionHandler)
    func webhooksServices(_ request: WebhooksServices.ListWebhooks, completionHandler: @escaping CompletionHandler)
    func webhooksServices(_ request: WebhooksServices.UpdateWebhook, completionHandler: @escaping CompletionHandler)
    func webhooksServices(_ request: WebhooksServices.DeleteWebhook, completionHandler: @escaping CompletionHandler)
    
    
//     Comment
    func commentsServices(_ request: CommentsService.CreateUpdateConversation , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.GetConversationById , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.FindConversationByIdCustomId , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.ListConversations , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.ListConversationsWithFilters , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.DeleteConversation , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.CreateAndPublishComment , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.CreateAndPublishCommentNewUser , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.ReplyToAComment , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.GetCommentById , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.ListComments , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.ListReplies , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.FlagCommentAsDeleted , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.DeleteCommentPermanent , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.UpdateComment , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.ReactToCommentLike , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.VoteUpOrDownOnComment , completionHandler: @escaping CompletionHandler)
    func commentsServices(_ request: CommentsService.ReportComment , completionHandler: @escaping CompletionHandler)
    
    
    
    
    func getUpdates(completionHandler: @escaping CompletionHandler)
    func listRooms(completionHandler: @escaping CompletionHandler)
    func joinRoom(room:[AnyHashable:Any])
    func listParticipants(cursor:String, maxresults:Int, completionHandler: @escaping CompletionHandler)
    func getCurrentRoom() -> [AnyHashable: Any]?
    func sendCommand(command:Any, userId:String, completionHandler: @escaping CompletionHandler)
    func sendGoal(message:String, options: [AnyHashable: Any], completionHandler: @escaping CompletionHandler)

}

open class ServicesAMS: ServicesBase, ServicesAMSProtocol
{
    
    internal var lastTimeStamp: Int64 = 0
    
    // MARK: - User Services
    public func usersServices(_ request: UsersServices.CreateUpdateUser, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.user)\(request.userid ?? emptyString)", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.DeleteUser, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.user)\(request.userid ?? emptyString)", withData: request.toDictionary(), requestType: .DELETE) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.GetUserDetails, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.user)\(request.userid ?? emptyString)", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.ListUsers, completionHandler: @escaping CompletionHandler)
    {
        makeRequest(ServiceKeys.user, withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.ListUsersMore, completionHandler: @escaping CompletionHandler)
    {
        makeRequest(ServiceKeys.user, withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.BanUser, completionHandler: @escaping CompletionHandler) {
        
        makeRequest("\(ServiceKeys.user)\(request.userid ?? emptyString)/ban", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.RestoreUser, completionHandler: @escaping CompletionHandler) {
        
        makeRequest("\(ServiceKeys.user)\(request.userid ?? emptyString)/ban", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.SearchUsersByHandle, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user/search", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.SearchUsersByName, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user/search", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.SearchUsersByUserId, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user/search", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    // MARK: - Chat Services, pending create room
    
    public func chatRoomsServices(_ request: ChatRoomsServices.CreateRoomPostmoderated, completionHandler: @escaping CompletionHandler) {
          makeRequest(ServiceKeys.chat, withData: request.toDictionary(), requestType: .POST) { (response) in
              completionHandler(response)
          }
      }
      
      public func chatRoomsServices(_ request: ChatRoomsServices.CreateRoomPremoderated, completionHandler: @escaping CompletionHandler) {
          makeRequest(ServiceKeys.chat, withData: request.toDictionary(), requestType: .POST) { (response) in
              completionHandler(response)
          }
      }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.GetRoomDetails , completionHandler: @escaping CompletionHandler)
       {
           
           makeRequest("\(ServiceKeys.chat)\(request.roomIdOrSlug ?? emptyString)", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
               completionHandler(response)
           }
       }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.DeleteRoom, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? "")", withData: request.toDictionary(), requestType: .DELETE) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.UpdateRoom , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? "")", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.UpdateRoomCloseARoom , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ListRooms , completionHandler: @escaping CompletionHandler)
    {
        makeRequest(ServiceKeys.chat, withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            if let responseData = response["data"] as? [[AnyHashable: Any]] {
                self.services.knownRooms = responseData
            }
            
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ListRoomParticipants , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/participants", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.JoinRoomAuthenticatedUser , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/join", withData: request.toDictionary(), requestType: .POST) { (response) in
            if let responseData = response["data"] as? [AnyHashable: Any] {
                if let data = responseData["room"] as? [AnyHashable: Any] {
                    self.services._currentRoom = data
                    self.setRoomAPI()
                }
            }
           
            completionHandler(response)
        }
    }
    
    private func setRoomAPI(){
        let roomApi = "\(ServiceKeys.chat)\((self.services._currentRoom?["id"] as? String) ?? "")"
        self.services._roomApi = roomApi
        self.services._commandApi = (self.services._roomApi ?? "") + "/command";
        self.services._updatesApi = (self.services._roomApi ?? "") + "/updates";
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.JoinRoomAnonymousUser , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/join", withData: request.toDictionary(), requestType: .POST) { (response) in
            if let responseData = response["data"] as? [AnyHashable: Any] {
                if let data = responseData["room"] as? [AnyHashable: Any] {
                    self.services._currentRoom = data
                }
            }
            self.setRoomAPI()
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ExitRoom , completionHandler: @escaping CompletionHandler)
      {
          makeRequest("\(ServiceKeys.chat)\(request.roomId ?? emptyString)/exit", withData: request.toDictionary(), requestType: .POST) { (response) in
              completionHandler(response)
          }
      }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.GetUpdates , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomId ?? emptyString)/updates", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.GetUpdatesMore , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomIdOrLabel ?? emptyString)/updates", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ExecuteChatCommand , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomId ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ExecuteDanceAction , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomId ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ReplyToAMessage , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomId ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ListMessagesByUser, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/messagesbyuser/\(request.userId ?? emptyString)", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.RemoveMessage, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.chat)\(request.chatRoomId ?? emptyString)/events/\(request.chatMessageId ?? emptyString)", withData: request.toDictionary(), requestType: .DELETE) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.PurgeUserMessages, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.chat)\(request.chatroomid ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ReportMessage, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.chat)\(request.chatRoomId ?? emptyString)/events/\(request.chat_room_newest_speech_id ?? emptyString)/report", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    public func chatRoomsServices(_ request: ChatRoomsServices.ReactToAMessageLike , completionHandler: @escaping CompletionHandler)
    {
        let url = "\(ServiceKeys.chat)\(request.roomId ?? emptyString)/events/\(request.roomNewestEventId ?? emptyString)/react"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ExecuteAdminCommand , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)\(request.roomId ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.DeleteAllEventsInRoom, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.chat)\(request.chatroomid ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    // MARK: - Web Hook Services
    public func webhooksServices(_ request: WebhooksServices.CreateReplaceWebhook, completionHandler: @escaping CompletionHandler)
    {
        makeRequest(ServiceKeys.webHooks, withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func webhooksServices(_ request: WebhooksServices.ListWebhooks, completionHandler: @escaping CompletionHandler)
    {
        makeRequest(ServiceKeys.webHooks, withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func webhooksServices(_ request: WebhooksServices.UpdateWebhook, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.webHooks)\(request.webhookId ?? emptyString)", withData: request.toDictionary(), requestType: .PUT) { (response) in
            completionHandler(response)
        }
    }
    
    public func webhooksServices(_ request: WebhooksServices.DeleteWebhook, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.webHooks)\(request.webhookId ?? emptyString)", withData: request.toDictionary(), requestType: .DELETE, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    // MARK: - Moderation Services
    
    public func moderationServices(_ request: ModerationServices.ApproveMessage , completionHandler: @escaping CompletionHandler)
    {
        let url = "\(ServiceKeys.chatModeration)\(request.chatMessageId ?? emptyString)/applydecision"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServices(_ request: ModerationServices.ListMessagesNeedingModeration , completionHandler: @escaping CompletionHandler)
    {
        let url = "chat/moderation/queues/events"
        makeRequest(url, withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServices(_ request: ModerationServices.ApproveCommentInQueue , completionHandler: @escaping CompletionHandler)
    {
        let url = "comment/moderation/queues/comments/\(request.commentid ?? emptyString)/applydecision"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServices(_ request: ModerationServices.RejectCommentInQueue , completionHandler: @escaping CompletionHandler)
    {
        let url = "comment/moderation/queues/comments/\(request.commentid ?? emptyString)/applydecision"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServices(_ request: ModerationServices.ListCommentsInModerationQueue , completionHandler: @escaping CompletionHandler)
    {
        let url = "comment/moderation/queues/comments"
        makeRequest(url, withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
        
    // MARK: - Comment Services
    public func commentsServices(_ request: CommentsService.CreateUpdateConversation, completionHandler: @escaping CompletionHandler) {
        
        makeRequest("\(ServiceKeys.comments)", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.GetConversationById, completionHandler: @escaping CompletionHandler) {
        let conversationId = request.comment_conversation_id ?? emptyString
        makeRequest("\(ServiceKeys.comments)\(conversationId)", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.FindConversationByIdCustomId, completionHandler: @escaping CompletionHandler) {
        makeRequest("comment/find/conversation/bycustomid?customid=\(request.customid ?? emptyString)", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.ListConversations, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.comments)", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.ListConversationsWithFilters, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.comments)", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.DeleteConversation, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)", withData: request.toDictionary(), requestType: .DELETE, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.CreateAndPublishComment, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.CreateAndPublishCommentNewUser, completionHandler: @escaping CompletionHandler) {
        makeRequest("\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.ReplyToAComment, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST) { (response) in
                   completionHandler(response)
               }
    }
    
    public func commentsServices(_ request: CommentsService.GetCommentById, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)"
        makeRequest(url, withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.ListComments, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/"
        makeRequest(url, withData: request.toDictionary(), requestType: .GET ) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.ListReplies, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)/replies"
        makeRequest(url, withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.FlagCommentAsDeleted, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)/setdeleted?userid=\(request.userid ?? emptyString)&deleted=\(request.deleted ?? true)"
        makeRequest(url, withData: request.toDictionary(), requestType: .PUT) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.DeleteCommentPermanent, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)"
        makeRequest(url, withData: request.toDictionary(), requestType: .DELETE) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.UpdateComment, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)"
        makeRequest(url, withData: request.toDictionary(), requestType: .PUT) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.ReactToCommentLike, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)/react"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.VoteUpOrDownOnComment, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)/vote"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func commentsServices(_ request: CommentsService.ReportComment, completionHandler: @escaping CompletionHandler) {
        let url = "\(ServiceKeys.comments)\(request.comment_conversation_id ?? emptyString)/comments/\(request.comment_comment_id ?? emptyString)/report"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    // MARK: - Misc
    public func listRooms(completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(ServiceKeys.chat)", withData: [AnyHashable: Any](), requestType: .GET, appendData: false) { (response) in
            if let responseData = response["data"] as? [[AnyHashable: Any]] {
                self.services.knownRooms = responseData
            }
            
            completionHandler(response)
        }
    }
    
    public func joinRoom(room:[AnyHashable:Any])
    {
        makeRequest("\(ServiceKeys.chat)\(room["id"] ?? "")/join", withData: ["userid": user?.userId ?? ""], requestType: .POST) { (response) in
            if let responseData = response["data"] as? [AnyHashable: Any] {
                if let data = responseData["room"] as? [AnyHashable: Any] {
                    self.services._currentRoom = data
                }
            }
            self.setRoomAPI()
        }
    }
    
    public func listParticipants(cursor:String, maxresults:Int = 200, completionHandler: @escaping CompletionHandler)
    {
        var urlString = ServiceKeys.chat
        urlString = urlString + ((self.services._currentRoom?["id"] as? String) ?? "") + "/participants?cursor="
        urlString = urlString + cursor + "&maxresults=" + String(200)
        
        makeRequest(urlString, withData: [AnyHashable: Any](), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func getCurrentRoom() -> [AnyHashable : Any]? {
        return services._currentRoom
    }
    
    public func sendCommand(command: Any, userId: String, completionHandler: @escaping CompletionHandler) {
        let dataDictionary = ["command": command, "userid": userId]
        
        makeRequest(self.services._commandApi ?? "", withData: dataDictionary, requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    internal func clearTimeStamp(){
        self.lastTimeStamp = 0
        print("clearTimeStamp called")
    }
    
    public func getUpdates(completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(services._updatesApi ?? "")", withData: [AnyHashable: Any](), requestType: .GET, appendData: false) { (response) in
            var sendResponse = response
            var data = response["data"] as? [String:Any]
            var newEvents = [[String:Any]]()
            if let events = data?["events"] as? [[String:Any]]{
                for event in events{
                    let timestamp = event["ts"] as? Int64 ?? 0
                    if timestamp > self.lastTimeStamp{
                        self.lastTimeStamp = timestamp
                        newEvents.append(event)
                    }
                }
            }
            if !newEvents.isEmpty{
                data?["events"] = newEvents
                sendResponse["data"] = data
                completionHandler(sendResponse)
            }
        }
    }
    
    public func sendGoal(message:String = "GOAL!", options: [AnyHashable: Any], completionHandler: @escaping CompletionHandler)
    {
        var json = ""
        let jsonData = try? JSONSerialization.data(withJSONObject: options, options: []);

        if let jsonData = jsonData
        {
             json = String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
        }
        
        let request = ["command":message, "customtype": "goal", "userid": user?.userId, "custompayload": json]
        
        makeRequest(services._commandApi, withData: request as [AnyHashable : Any], requestType: .POST, appendData: false) { (response) in
            completionHandler(response)
        }
    }
}


