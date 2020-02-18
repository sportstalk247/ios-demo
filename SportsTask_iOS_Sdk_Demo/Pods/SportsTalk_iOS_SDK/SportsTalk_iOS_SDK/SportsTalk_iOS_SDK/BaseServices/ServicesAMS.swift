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
    
    var services: Services? { get }
    var user: User? { get set }
    
    func usersServices(_ request: UsersServices.CreateUpdateUser, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.GetUserDetails, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.ListUsers, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.ListUsersMore, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.ListMessagesByUser, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.SearchUsersByHandle, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.SearchUsersByName, completionHandler: @escaping CompletionHandler)
    func usersServices(_ request: UsersServices.SearchUsersByUserId, completionHandler: @escaping CompletionHandler)
    
    func webhooksServices(_ request: WebhooksServices.CreateReplaceWebhook, completionHandler: @escaping CompletionHandler)
    func webhooksServices(_ request: WebhooksServices.ListWebhooks, completionHandler: @escaping CompletionHandler)
    func webhooksServices(_ request: WebhooksServices.UpdateWebhook, completionHandler: @escaping CompletionHandler)
    func webhooksServices(_ request: WebhooksServices.DeleteWebhook, completionHandler: @escaping CompletionHandler)
    
    func moderationServies(_ request: ModerationServices.BanUser, completionHandler: @escaping CompletionHandler)
    func moderationServies(_ request: ModerationServices.RestoreUser, completionHandler: @escaping CompletionHandler)
    func moderationServies(_ request: ModerationServices.PurgeUserMessages, completionHandler: @escaping CompletionHandler)
    func moderationServies(_ request: ModerationServices.DeleteAllEventsInRoom, completionHandler: @escaping CompletionHandler)
    func moderationServies(_ request: ModerationServices.RemoveMessage, completionHandler: @escaping CompletionHandler)
    func moderationServies(_ request: ModerationServices.ReportMessage, completionHandler: @escaping CompletionHandler)
    func moderationServies(_ request: ModerationServices.ApproveMessage , completionHandler: @escaping CompletionHandler)
    
    
    func chatRoomsServices(_ request: ChatRoomsServices.CreateRoom , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.UpdateRoom , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.UpdateRoomCloseARoom , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ListRooms , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ListRoomParticipants , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.JoinRoomAuthenticatedUser , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.JoinRoomAnonymousUser , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.GetUpdates , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.GetUpdatesMore , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ExecuteChatCommand , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ExecuteDanceAction , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ReplyToAMessage , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ReactToAMessageLike , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ExecuteAdminCommand , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.ExitRoom , completionHandler: @escaping CompletionHandler)
    func chatRoomsServices(_ request: ChatRoomsServices.GetRoomDetails , completionHandler: @escaping CompletionHandler)
    
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
    public func usersServices(_ request: UsersServices.CreateUpdateUser, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user/\(request.userid ?? emptyString)", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.GetUserDetails, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user/\(request.userid ?? emptyString)", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.ListUsers, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.ListUsersMore, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func usersServices(_ request: UsersServices.ListMessagesByUser, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user/\(request.userId ?? emptyString)", withData: request.toDictionary(), requestType: .GET) { (response) in
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
    
    public func webhooksServices(_ request: WebhooksServices.CreateReplaceWebhook, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("webhook", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func webhooksServices(_ request: WebhooksServices.ListWebhooks, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("webhook", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func webhooksServices(_ request: WebhooksServices.UpdateWebhook, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("webhook/\(request.webhookId ?? emptyString)", withData: request.toDictionary(), requestType: .PUT) { (response) in
            completionHandler(response)
        }
    }
    
    public func webhooksServices(_ request: WebhooksServices.DeleteWebhook, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("webhook/\(request.webhookId ?? emptyString)", withData: request.toDictionary(), requestType: .DELETE, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServies(_ request: ModerationServices.BanUser, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user/\(request.userid ?? emptyString)/ban", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServies(_ request: ModerationServices.RestoreUser, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("user/\(request.userid ?? emptyString)/ban", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServies(_ request: ModerationServices.PurgeUserMessages, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.chatroomid ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServies(_ request: ModerationServices.DeleteAllEventsInRoom, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.chatroomid ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServies(_ request: ModerationServices.RemoveMessage, completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.chatRoomId ?? emptyString)/remove/\(request.chatMessageId ?? emptyString)", withData: request.toDictionary(), requestType: .POST, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServies(_ request: ModerationServices.ReportMessage , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.chatRoomId ?? emptyString)/report/\(request.chat_room_newest_speech_id ?? emptyString)", withData: request.toDictionary(), requestType: .POST, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func moderationServies(_ request: ModerationServices.ApproveMessage , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.chatRoomId ?? emptyString)/approve/\(request.chatMessageId ?? emptyString)", withData: request.toDictionary(), requestType: .POST, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.CreateRoom , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.UpdateRoom , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.UpdateRoomCloseARoom , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomid ?? emptyString)", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ListRooms , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            if let responseData = response["data"] as? [[AnyHashable: Any]] {
                self.services?.knownRooms = responseData
            }
            
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ListRoomParticipants , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomid ?? emptyString)/participants", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.JoinRoomAuthenticatedUser , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomid ?? emptyString)/join", withData: request.toDictionary(), requestType: .POST) { (response) in
            if let responseData = response["data"] as? [AnyHashable: Any] {
                if let data = responseData["room"] as? [AnyHashable: Any] {
                    self.services?._currentRoom = data
                }
            }
            
            var _roomApiString = (self.services?._endpoint?.absoluteString ?? "") + "/room/"
            _roomApiString = _roomApiString + ((self.services?._currentRoom?["id"] as? String) ?? "")
            self.services?._roomApi = _roomApiString
            
            self.services?._commandApi = (self.services?._roomApi ?? "") + "/command";
            self.services?._updatesApi = (self.services?._roomApi ?? "") + "/updates";
            
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.JoinRoomAnonymousUser , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomid ?? emptyString)/join", withData: request.toDictionary(), requestType: .POST) { (response) in
            if let responseData = response["data"] as? [AnyHashable: Any] {
                if let data = responseData["room"] as? [AnyHashable: Any] {
                    self.services?._currentRoom = data
                }
            }
            
            var _roomApiString = (self.services?._endpoint?.absoluteString ?? "") + "/room/"
            _roomApiString = _roomApiString + ((self.services?._currentRoom?["id"] as? String) ?? "")
            self.services?._roomApi = _roomApiString
            
            self.services?._commandApi = (self.services?._roomApi ?? "") + "/command";
            self.services?._updatesApi = (self.services?._roomApi ?? "") + "/updates";
            
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.GetUpdates , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomId ?? emptyString)/updates", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.GetUpdatesMore , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomIdOrLabel ?? emptyString)/updates", withData: request.toDictionary(), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ExecuteChatCommand , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomId ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ExecuteDanceAction , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomId ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ReplyToAMessage , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomId ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ReactToAMessageLike , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomId ?? emptyString)/react/\(request.roomNewestEventId ?? emptyString)", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ExecuteAdminCommand , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomId ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.ExitRoom , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomId ?? emptyString)/exit", withData: request.toDictionary(), requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func chatRoomsServices(_ request: ChatRoomsServices.GetRoomDetails , completionHandler: @escaping CompletionHandler)
    {
        makeRequest("room/\(request.roomIdOrSlug ?? emptyString)", withData: request.toDictionary(), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
        }
    }
    
    public func listRooms(completionHandler: @escaping CompletionHandler)
    {
        makeRequest("\(self.services?._endpoint?.absoluteString ?? "")/room", withData: [AnyHashable: Any](), requestType: .GET, appendData: false) { (response) in
            if let responseData = response["data"] as? [[AnyHashable: Any]] {
                self.services?.knownRooms = responseData
            }
            
            completionHandler(response)
        }
    }
    
    public func joinRoom(room:[AnyHashable:Any])
    {
        makeRequest("room/\(room["id"] ?? "")/join", withData: ["userid": user?.userId ?? ""], requestType: .POST) { (response) in
            if let responseData = response["data"] as? [AnyHashable: Any] {
                if let data = responseData["room"] as? [AnyHashable: Any] {
                    self.services?._currentRoom = data
                }
            }
            
            var _roomApiString = (self.services?._endpoint?.absoluteString ?? "") + "/room/"
            _roomApiString = _roomApiString + ((self.services?._currentRoom?["id"] as? String) ?? "")
            self.services?._roomApi = _roomApiString
            
            self.services?._commandApi = (self.services?._roomApi ?? "") + "/command";
            self.services?._updatesApi = (self.services?._roomApi ?? "") + "/updates";
        }
    }
    
    public func listParticipants(cursor:String, maxresults:Int = 200, completionHandler: @escaping CompletionHandler)
    {
        var urlString = (services?._endpoint?.absoluteString ?? "") + "/room/"
        urlString = urlString + ((self.services?._currentRoom?["id"] as? String) ?? "") + "/participants?cursor="
        urlString = urlString + cursor + "&maxresults=" + String(200)
        
        makeRequest(urlString, withData: [AnyHashable: Any](), requestType: .GET) { (response) in
            completionHandler(response)
        }
    }
    
    public func getCurrentRoom() -> [AnyHashable : Any]? {
        return services?._currentRoom
    }
    
    public func sendCommand(command: Any, userId: String, completionHandler: @escaping CompletionHandler) {
        let dataDictionary = ["command": command, "userid": userId]
        
        makeRequest(self.services?._commandApi ?? "", withData: dataDictionary, requestType: .POST) { (response) in
            completionHandler(response)
        }
    }
    
    public func getUpdates(completionHandler: @escaping CompletionHandler)
    {
        makeRequest(services?._updatesApi, withData: [AnyHashable: Any](), requestType: .GET, appendData: false) { (response) in
            completionHandler(response)
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
        
        makeRequest(services?._commandApi, withData: request as [AnyHashable : Any], requestType: .POST, appendData: false) { (response) in
            completionHandler(response)
        }
    }
}


