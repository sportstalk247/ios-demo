import Foundation

public protocol ChatClientProtocol {
    func createRoom(_ request: ChatRequest.CreateRoom, completionHandler: @escaping Completion<ChatRoom>)
    func getRoomDetails(_ request: ChatRequest.GetRoomDetails, completionHandler: @escaping Completion<ChatRoom>)
    func deleteRoom(_ request: ChatRequest.DeleteRoom, completionHandler: @escaping Completion<DeleteChatRoomResponse>)
    func updateRoom(_ request: ChatRequest.UpdateRoom, completionHandler: @escaping Completion<ChatRoom>)
    func updateCloseRoom(_ request: ChatRequest.UpdateRoomCloseARoom, completionHandler: @escaping Completion<ChatRoom>)
    func listRooms(_ request: ChatRequest.ListRooms, completionHandler: @escaping Completion<ListRoomsResponse>)
    func listRoomParticipants(_ request: ChatRequest.ListRoomParticipants, completionHandler: @escaping Completion<ListChatRoomParticipantsResponse>)
    func joinRoom(_ request: ChatRequest.JoinRoom, completionHandler: @escaping Completion<JoinChatRoomResponse>)
    func joinRoomByCustomId(_ request: ChatRequest.JoinRoomByCustomId, completionHandler: @escaping Completion<JoinChatRoomResponse>)
    func exitRoom(_ request: ChatRequest.ExitRoom, completionHandler: @escaping Completion<ExitChatRoomResponse>)
    func getUpdates(_ request: ChatRequest.GetUpdates, completionHandler: @escaping Completion<GetUpdatesResponse>)
    func executeChatCommand(_ request: ChatRequest.ExecuteChatCommand, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
    func sendQuotedReply(_ request: ChatRequest.SendQuotedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
    func sendThreadedReply(_ request: ChatRequest.SendThreadedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
//    func permanentlyDeleteEvent(_ request: ChatRoomsServices.PermanentlyDeleteEvent, completionHandler: @escaping Completion<Event>)
//    func flagEventLogicallyDeleted(_ request: ChatRoomsServices.SendQuotedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
    func listMessagesByUser(_ request: ChatRequest.ListMessagesByUser, completionHandler: @escaping Completion<ListMessagesByUser>)
    func reportMessage(_ request: ChatRequest.ReportMessage, completionHandler: @escaping Completion<Event>)
    func reactToEvent(_ request: ChatRequest.ReactToEvent, completionHandler: @escaping Completion<Event>)
    func startListeningToChatUpdates(completionHandler: @escaping Completion<[Event]>)
    func stopListeningToChatUpdates()
    
    func approveEvent(_ request: ModerationRequest.ApproveEvent, completionHandler: @escaping Completion<Event>)
    func rejectEvent(_ request: ModerationRequest.RejectEvent, completionHandler: @escaping Completion<Event>)
    func listMessagesInModerationQueue(_ request: ModerationRequest.listMessagesInModerationQueue, completionHandler: @escaping Completion<ListMessagesNeedingModerationResponse>)
}

public class ChatClient: NetworkService, ChatClientProtocol {
    var timer: Timer?
    var lastCursor: String = ""
    var lastRoomId: String?
    
    public override init(config: ClientConfig) {
        super.init(config: config)
    }
    
    deinit {
        stopListeningToChatUpdates()
    }
}

extension ChatClient {
    public func createRoom(_ request: ChatRequest.CreateRoom, completionHandler: @escaping Completion<ChatRoom>) {
        makeRequest(ServiceKeys.chat, withData: request.toDictionary(), requestType: .POST, expectation: ChatRoom.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func getRoomDetails(_ request: ChatRequest.GetRoomDetails, completionHandler: @escaping Completion<ChatRoom>) {
        makeRequest(ServiceKeys.chat, withData: request.toDictionary(), requestType: .GET, expectation: ChatRoom.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func deleteRoom(_ request: ChatRequest.DeleteRoom, completionHandler: @escaping Completion<DeleteChatRoomResponse>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? "")", withData: request.toDictionary(), requestType: .DELETE, expectation: DeleteChatRoomResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func updateRoom(_ request: ChatRequest.UpdateRoom, completionHandler: @escaping Completion<ChatRoom>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? "")", withData: request.toDictionary(), requestType: .POST, expectation: ChatRoom.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func updateCloseRoom(_ request: ChatRequest.UpdateRoomCloseARoom, completionHandler: @escaping Completion<ChatRoom>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)", withData: request.toDictionary(), requestType: .POST, expectation: ChatRoom.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func listRooms(_ request: ChatRequest.ListRooms, completionHandler: @escaping Completion<ListRoomsResponse>) {
        makeRequest(ServiceKeys.chat, withData: request.toDictionary(), requestType: .GET, expectation: ListRoomsResponse.self, append: false) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }

    }

    public func listRoomParticipants(_ request: ChatRequest.ListRoomParticipants, completionHandler: @escaping Completion<ListChatRoomParticipantsResponse>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/participants", withData: request.toDictionary(), requestType: .GET, expectation: ListChatRoomParticipantsResponse.self, append: false) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func joinRoom(_ request: ChatRequest.JoinRoom, completionHandler: @escaping Completion<JoinChatRoomResponse>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/join", withData: request.toDictionary(), requestType: .POST, expectation: JoinChatRoomResponse.self) { (response) in
            self.lastRoomId = request.roomid
            self.lastCursor = ""
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func joinRoomByCustomId(_ request: ChatRequest.JoinRoomByCustomId, completionHandler: @escaping Completion<JoinChatRoomResponse>) {
        makeRequest("\(ServiceKeys.chatCustom)\(request.customid ?? emptyString)/join", withData: request.toDictionary(), requestType: .POST, expectation: JoinChatRoomResponse.self) { (response) in
            self.lastRoomId = request.customid
            self.lastCursor = ""
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func exitRoom(_ request: ChatRequest.ExitRoom, completionHandler: @escaping Completion<ExitChatRoomResponse>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/exit", withData: request.toDictionary(), requestType: .POST, expectation: ExitChatRoomResponse.self) { (response) in
            self.stopListeningToChatUpdates()
            self.lastRoomId = nil
            self.lastCursor = ""
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func getUpdates(_ request: ChatRequest.GetUpdates, completionHandler: @escaping Completion<GetUpdatesResponse>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/updates", withData: request.toDictionary(), requestType: .GET, expectation: GetUpdatesResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func executeChatCommand(_ request: ChatRequest.ExecuteChatCommand, completionHandler: @escaping Completion<ExecuteChatCommandResponse>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST, expectation: ExecuteChatCommandResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func sendQuotedReply(_ request: ChatRequest.SendQuotedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST, expectation: ExecuteChatCommandResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func sendThreadedReply(_ request: ChatRequest.SendThreadedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/command", withData: request.toDictionary(), requestType: .POST, expectation: ExecuteChatCommandResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func listMessagesByUser(_ request: ChatRequest.ListMessagesByUser, completionHandler: @escaping Completion<ListMessagesByUser>) {
        makeRequest("\(ServiceKeys.chat)\(request.roomid ?? emptyString)/messagesbyuser/\(request.userId ?? emptyString)", withData: request.toDictionary(), requestType: .GET, expectation: ListMessagesByUser.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func reportMessage(_ request: ChatRequest.ReportMessage, completionHandler: @escaping Completion<Event>) {
        makeRequest("\(ServiceKeys.chat)\(request.chatRoomId ?? emptyString)/events/\(request.chat_room_newest_speech_id ?? emptyString)/report", withData: request.toDictionary(), requestType: .POST, expectation: Event.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func reactToEvent(_ request: ChatRequest.ReactToEvent, completionHandler: @escaping Completion<Event>) {
        let url = "\(ServiceKeys.chat)\(request.roomid ?? emptyString)/events/\(request.eventid ?? emptyString)/react"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST, expectation: Event.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
}


//MARK: - Moderation
extension ChatClient {
    public func approveEvent(_ request: ModerationRequest.ApproveEvent, completionHandler: @escaping Completion<Event>) {
        let url = "\(ServiceKeys.chatModeration)\(request.chatMessageId ?? emptyString)/applydecision"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST, expectation: Event.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func rejectEvent(_ request: ModerationRequest.RejectEvent, completionHandler: @escaping Completion<Event>) {
        let url = "\(ServiceKeys.chatModeration)\(request.chatMessageId ?? emptyString)/applydecision"
        makeRequest(url, withData: request.toDictionary(), requestType: .POST, expectation: Event.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listMessagesInModerationQueue(_ request: ModerationRequest.listMessagesInModerationQueue, completionHandler: @escaping Completion<ListMessagesNeedingModerationResponse>) {
        let url = "chat/moderation/queues/events"
        makeRequest(url, withData: request.toDictionary(), requestType: .GET, expectation: ListMessagesNeedingModerationResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
}

// MARK: - Event Subscription
extension ChatClient {
    public func startListeningToChatUpdates(completionHandler: @escaping Completion<[Event]>) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            let request = ChatRequest.GetUpdates()
            request.roomid = self.lastRoomId
            request.cursor = self.lastCursor
            
            self.getUpdates(request) { [weak self] (code, message, kind, response) in
                // Invalid timer should disregard further update results
                guard
                    let self = self,
                    let timer = self.timer,
                    timer.isValid
                else {
                    return
                }
                
                if let response = response {
                    var emittableEvents = [Event]()
                    
                    if let cursor = response.cursor {
                        if !cursor.isEmpty {
                            self.lastCursor = cursor
                        }
                    }
                    
                    emittableEvents = response.events
                    
                    completionHandler(code, message, kind, emittableEvents)
                }
            }
        })
    }
    
    public func stopListeningToChatUpdates() {
        timer?.invalidate()
    }
}
