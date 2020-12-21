import Foundation

public protocol ChatClientProtocol {
    func createRoom(_ request: ChatRequest.CreateRoom, completionHandler: @escaping Completion<ChatRoom>)
    func getRoomDetails(_ request: ChatRequest.GetRoomDetails, completionHandler: @escaping Completion<ChatRoom>)
    func deleteRoom(_ request: ChatRequest.DeleteRoom, completionHandler: @escaping Completion<DeleteChatRoomResponse>)
    func updateRoom(_ request: ChatRequest.UpdateRoom, completionHandler: @escaping Completion<ChatRoom>)
    func updateCloseRoom(_ request: ChatRequest.UpdateRoomCloseARoom, completionHandler: @escaping Completion<ChatRoom>)
    func listRooms(_ request: ChatRequest.ListRooms, completionHandler: @escaping Completion<ListRoomsResponse>)
    func listRoomParticipants(_ request: ChatRequest.ListRoomParticipants, completionHandler: @escaping Completion<ListChatRoomParticipantsResponse>)
    func listEventHistory(_ request: ChatRequest.ListEventHistory, completionHandler: @escaping Completion<ListEventsResponse>)
    func listPreviousEvents(_ request: ChatRequest.ListPreviousEvents,completionHandler: @escaping Completion<ListEventsResponse>)
    func joinRoom(_ request: ChatRequest.JoinRoom, completionHandler: @escaping Completion<JoinChatRoomResponse>)
    func joinRoomByCustomId(_ request: ChatRequest.JoinRoomByCustomId, completionHandler: @escaping Completion<JoinChatRoomResponse>)
    func exitRoom(_ request: ChatRequest.ExitRoom, completionHandler: @escaping Completion<ExitChatRoomResponse>)
    func getUpdates(_ request: ChatRequest.GetUpdates, completionHandler: @escaping Completion<GetUpdatesResponse>)
    func executeChatCommand(_ request: ChatRequest.ExecuteChatCommand, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
    func sendQuotedReply(_ request: ChatRequest.SendQuotedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
    func sendThreadedReply(_ request: ChatRequest.SendThreadedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
    func purgeMessage(_ request: ChatRequest.PurgeUserMessages, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
    func flagEventLogicallyDeleted(_ request: ChatRequest.FlagEventLogicallyDeleted, completionHandler: @escaping Completion<DeleteEventResponse>)
    func deleteEvent(_ request: ChatRequest.DeleteEvent, completionHandler: @escaping Completion<DeleteEventResponse>)
    func deleteAllEvents(_ request: ChatRequest.DeleteAllEvents, completionHandler: @escaping Completion<ExecuteChatCommandResponse>)
    func listMessagesByUser(_ request: ChatRequest.ListMessagesByUser, completionHandler: @escaping Completion<ListMessagesByUser>)
    func reportMessage(_ request: ChatRequest.ReportMessage, completionHandler: @escaping Completion<Event>)
    func reactToEvent(_ request: ChatRequest.ReactToEvent, completionHandler: @escaping Completion<Event>)
    func bounceUser(_ request: ChatRequest.BounceUser, completionHandler: @escaping Completion<BounceUserRequest>)
    func startListeningToChatUpdates(completionHandler: @escaping Completion<[Event]>)
    func stopListeningToChatUpdates()
    
    func approveEvent(_ request: ModerationRequest.ApproveEvent, completionHandler: @escaping Completion<Event>)
    func rejectEvent(_ request: ModerationRequest.RejectEvent, completionHandler: @escaping Completion<Event>)
    func listMessagesInModerationQueue(_ request: ModerationRequest.listMessagesInModerationQueue, completionHandler: @escaping Completion<ListMessagesNeedingModerationResponse>)
}

public class ChatClient: NetworkService, ChatClientProtocol {
    var timer: Timer?
    var firstCursor: String = "" { didSet { print("first: \(firstCursor)") } }
    var lastCursor: String = "" { didSet { print("last: \(lastCursor)") } }
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
        makeRequest(URLPath.Room.Create(), withData: request.toDictionary(), requestType: .POST, expectation: ChatRoom.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func getRoomDetails(_ request: ChatRequest.GetRoomDetails, completionHandler: @escaping Completion<ChatRoom>) {
        makeRequest(URLPath.Room.Details(roomid: request.roomid), withData: request.toDictionary(), requestType: .GET, expectation: ChatRoom.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func deleteRoom(_ request: ChatRequest.DeleteRoom, completionHandler: @escaping Completion<DeleteChatRoomResponse>) {
        makeRequest(URLPath.Room.Delete(roomid: request.roomid), withData: request.toDictionary(), requestType: .DELETE, expectation: DeleteChatRoomResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func updateRoom(_ request: ChatRequest.UpdateRoom, completionHandler: @escaping Completion<ChatRoom>) {
        makeRequest(URLPath.Room.Update(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: ChatRoom.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func updateCloseRoom(_ request: ChatRequest.UpdateRoomCloseARoom, completionHandler: @escaping Completion<ChatRoom>) {
        makeRequest(URLPath.Room.Close(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: ChatRoom.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func listRooms(_ request: ChatRequest.ListRooms, completionHandler: @escaping Completion<ListRoomsResponse>) {
        makeRequest(URLPath.Room.List(), withData: request.toDictionary(), requestType: .GET, expectation: ListRoomsResponse.self, append: false) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func listRoomParticipants(_ request: ChatRequest.ListRoomParticipants, completionHandler: @escaping Completion<ListChatRoomParticipantsResponse>) {
        makeRequest(URLPath.Room.Participants(roomid: request.roomid), withData: request.toDictionary(), requestType: .GET, expectation: ListChatRoomParticipantsResponse.self, append: false) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listEventHistory(_ request: ChatRequest.ListEventHistory, completionHandler: @escaping Completion<ListEventsResponse>) {
        makeRequest(URLPath.Room.EventHistory(roomid: request.roomid), withData: request.toDictionary(), requestType: .GET, expectation: ListEventsResponse.self, append: true) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listPreviousEvents(_ request: ChatRequest.ListPreviousEvents,completionHandler: @escaping Completion<ListEventsResponse>) {
        request.cursor = self.firstCursor
        makeRequest(URLPath.Room.PreviousEvent(roomid: request.roomid), withData: request.toDictionary(), requestType: .GET, expectation: ListEventsResponse.self, append: true) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
            self.firstCursor = response?.data?.cursor ?? ""
        }
    }
    
    public func joinRoom(_ request: ChatRequest.JoinRoom, completionHandler: @escaping Completion<JoinChatRoomResponse>) {
        makeRequest(URLPath.Room.Join(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: JoinChatRoomResponse.self) { (response) in
            self.lastRoomId = request.roomid
            self.lastCursor = ""
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
            self.firstCursor = response?.data?.eventscursor?.cursor ?? ""
        }
    }
    
    public func joinRoomByCustomId(_ request: ChatRequest.JoinRoomByCustomId, completionHandler: @escaping Completion<JoinChatRoomResponse>) {
        makeRequest(URLPath.Room.Join(customid: request.customid), withData: request.toDictionary(), requestType: .POST, expectation: JoinChatRoomResponse.self) { (response) in
            self.lastRoomId = request.customid
            self.lastCursor = ""
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
            self.firstCursor = response?.data?.eventscursor?.cursor ?? ""
        }
    }

    public func exitRoom(_ request: ChatRequest.ExitRoom, completionHandler: @escaping Completion<ExitChatRoomResponse>) {
        makeRequest(URLPath.Room.Exit(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: ExitChatRoomResponse.self) { (response) in
            self.stopListeningToChatUpdates()
            self.lastRoomId = nil
            self.lastCursor = ""
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func getUpdates(_ request: ChatRequest.GetUpdates, completionHandler: @escaping Completion<GetUpdatesResponse>) {
        makeRequest(URLPath.Room.Update(roomid: request.roomid), withData: request.toDictionary(), requestType: .GET, expectation: GetUpdatesResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func executeChatCommand(_ request: ChatRequest.ExecuteChatCommand, completionHandler: @escaping Completion<ExecuteChatCommandResponse>) {
        makeRequest(URLPath.Room.ExecuteCommand(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: ExecuteChatCommandResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func sendQuotedReply(_ request: ChatRequest.SendQuotedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>) {
        makeRequest(URLPath.Room.QuotedReply(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: ExecuteChatCommandResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func sendThreadedReply(_ request: ChatRequest.SendThreadedReply, completionHandler: @escaping Completion<ExecuteChatCommandResponse>) {
        makeRequest(URLPath.Room.ThreadedReply(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: ExecuteChatCommandResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    
    public func purgeMessage(_ request: ChatRequest.PurgeUserMessages, completionHandler: @escaping Completion<ExecuteChatCommandResponse>) {
        makeRequest(URLPath.Event.Purge(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: ExecuteChatCommandResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func flagEventLogicallyDeleted(_ request: ChatRequest.FlagEventLogicallyDeleted, completionHandler: @escaping Completion<DeleteEventResponse>) {
        makeRequest(URLPath.Event.FlagLogicallyDeleted(roomid: request.roomid, eventid: request.eventid), withData: request.toDictionary(), requestType: .DELETE, expectation: DeleteEventResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func deleteEvent(_ request: ChatRequest.DeleteEvent, completionHandler: @escaping Completion<DeleteEventResponse>) {
        makeRequest(URLPath.Event.Delete(roomid: request.roomid, eventid: request.eventid), withData: request.toDictionary(), requestType: .DELETE, expectation: DeleteEventResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func deleteAllEvents(_ request: ChatRequest.DeleteAllEvents, completionHandler: @escaping Completion<ExecuteChatCommandResponse>) {
        makeRequest(URLPath.Event.DeleteAll(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: ExecuteChatCommandResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func listMessagesByUser(_ request: ChatRequest.ListMessagesByUser, completionHandler: @escaping Completion<ListMessagesByUser>) {
        makeRequest(URLPath.Event.ListByUser(roomid: request.roomid, userid: request.userId), withData: request.toDictionary(), requestType: .GET, expectation: ListMessagesByUser.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func reportMessage(_ request: ChatRequest.ReportMessage, completionHandler: @escaping Completion<Event>) {
        makeRequest(URLPath.Event.Report(roomid: request.chatRoomId, eventid: request.chat_room_newest_speech_id), withData: request.toDictionary(), requestType: .POST, expectation: Event.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func reactToEvent(_ request: ChatRequest.ReactToEvent, completionHandler: @escaping Completion<Event>) {
        makeRequest(URLPath.Event.React(roomid: request.roomid, eventid: request.eventid), withData: request.toDictionary(), requestType: .POST, expectation: Event.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func bounceUser(_ request: ChatRequest.BounceUser, completionHandler: @escaping Completion<BounceUserRequest>) {
        makeRequest(URLPath.Room.Bounce(roomid: request.roomid), withData: request.toDictionary(), requestType: .POST, expectation: BounceUserRequest.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
}


// MARK: - Moderation
extension ChatClient {
    public func approveEvent(_ request: ModerationRequest.ApproveEvent, completionHandler: @escaping Completion<Event>) {
        makeRequest(URLPath.Mod.Approve(eventid: request.chatMessageId), withData: request.toDictionary(), requestType: .POST, expectation: Event.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func rejectEvent(_ request: ModerationRequest.RejectEvent, completionHandler: @escaping Completion<Event>) {
        makeRequest(URLPath.Mod.Reject(eventid: request.chatMessageId), withData: request.toDictionary(), requestType: .POST, expectation: Event.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listMessagesInModerationQueue(_ request: ModerationRequest.listMessagesInModerationQueue, completionHandler: @escaping Completion<ListMessagesNeedingModerationResponse>) {
        makeRequest(URLPath.Mod.List(), withData: request.toDictionary(), requestType: .GET, expectation: ListMessagesNeedingModerationResponse.self) { (response) in
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
