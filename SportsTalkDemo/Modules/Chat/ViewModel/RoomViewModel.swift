//
//  RoomViewModel.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 5/26/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import Combine
import SportsTalk247
import MessageKit

class RoomViewModel {
    var cancellables = Set<AnyCancellable>()
    let newEvents = PassthroughSubject<[Event], Never>()
    let previousEvents = PassthroughSubject<[Event], Never>()
    let isLoading = PassthroughSubject<Bool, Never>()
    let shouldReload = PassthroughSubject<IndexPath, Never>()
    let participants = PassthroughSubject<[ChatRoomParticipant], Never>()
    let reactedEvent = PassthroughSubject<Event, Never>()
    let deletedEvent = PassthroughSubject<Event, Never>()
    let errorMsg = PassthroughSubject<String, Never>()
    
    var activeRoom: ChatRoom
    
    init(room: ChatRoom) {
        self.activeRoom = room
        self.haveActorsJoinThisRoom()
    }
}

extension RoomViewModel {
    func fetchParticipants() {
        guard let roomId = activeRoom.id else { return }
        
        isLoading.send(true)
        
        let request = ChatRequest.ListRoomParticipants(
            roomid: roomId
        )
        
        Session.manager.chatClient.listRoomParticipants(request) { (code, message, _, response) in
            self.isLoading.send(false)
            guard let response = response else { return }
            self.participants.send(response.participants)
        }
    }
    
    func exitRoom(completion: @escaping (_ success: Bool) -> Void) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }
        
        let request = ChatRequest.ExitRoom(
            roomid: roomId,
            userid: userId
        )
        
        isLoading.send(true)
        
        Session.manager.chatClient.exitRoom(request) { (code, _, _, _) in
            self.isLoading.send(false)
            completion(code == 200)
        }
    }
    
    func startListening() {
        Session.manager.chatClient.startListeningToChatUpdates { (_, _, _, events) in
            guard var events = events else {
                return
            }
            
            // Do not display reaction events
            events.removeAll { (event) -> Bool in
                if let type = event.eventtype {
                    if type == .reaction {
                        self.reactedEvent.send(event)
                        return true
                    }
                }
                return false
            }
            
            self.newEvents.send(events)
        }
    }
    
    func sendMessage(_ message: String) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }
        
        let request = ChatRequest.ExecuteChatCommand(
            roomid: roomId,
            command: message,
            userid: userId
        )
        
        do {
            try Session.manager.chatClient.executeChatCommand(request) { (code, message, _, response) in
                if code == 200 {
                    // Success
                } else {
                    guard let message = message else { return }
                    self.errorMsg.send(message)
                }
            }
        } catch {
            print("RoomViewModel::sendMessage() -> error = \(error.localizedDescription)")
        }
    }
    
    func sendReply(_ reply: String, to message: Message) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }
        
        let request = ChatRequest.SendQuotedReply(
            roomid: roomId,
            eventid: message.messageId,
            userid: userId,
            body: reply
        )
        
        do {
            try Session.manager.chatClient.sendQuotedReply(request) { (code, _, kind, response) in
                if code == 200 {
                    // Success
                }
            }
        } catch {
            print("RoomViewModel::sendReply() -> error = \(error.localizedDescription)")
        }
    }
    
    func sendLike(to messageId: String, at indexPath: IndexPath) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }
        
        let request = ChatRequest.ReactToEvent(
            roomid: roomId,
            eventid: messageId,
            userid: userId,
            reaction: "like",
            reacted: true
        )
        
        Session.manager.chatClient.reactToEvent(request) { (code, message, _, response) in
            if code == 200 {
            } else {
                guard let message = message else { return }
                self.errorMsg.send(message)
            }
        }
    }
    
    func report(_ message: Message, at indexPath: IndexPath) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }
        
        let request = ChatRequest.ReportMessage(
            roomid: roomId,
            eventid: message.messageId,
            userid: userId,
            reporttype: .abuse
        )
        
        Session.manager.chatClient.reportMessage(request) { (code, serverMessage, _, reponse) in
            if code == 200 {
                self.errorMsg.send("\(message.actor.handle)'s message has been reported.")
            } else {
                guard let message = serverMessage else { return }
                self.errorMsg.send(message)
            }
        }
    }
    
    func delete(_ message: Message) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }

        let request = ChatRequest.PermanentlyDeleteEvent(
            roomid: roomId,
            eventid: message.messageId,
            userid: userId
        )
        
        Session.manager.chatClient.permanentlyDeleteEvent(request) { (code, serverMessage, _, response) in
            if code == 200 {
                guard let event = response?.event else { return }
                self.errorMsg.send("Your message has been deleted.")
                self.deletedEvent.send(event)
            } else {
                guard let message = serverMessage else { return }
                self.errorMsg.send(message)
            }
        }
    }
    
    func flagAsLogicallyDeleted(_ message: Message) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else { return }

        let request = ChatRequest.FlagEventLogicallyDeleted(
            roomid: roomId,
            eventid: message.messageId,
            userid: userId,
            deleted: false,
            permanentifnoreplies: true
        )

        Session.manager.chatClient.flagEventLogicallyDeleted(request) { (code, serverMessage, _, response) in
            if code == 200 {
                guard let event = response?.event else { return }
                self.errorMsg.send("Your message has been deleted.")
                self.deletedEvent.send(event)
            } else {
                guard let message = serverMessage else { return }
                self.errorMsg.send(message)
            }
        }
    }
    
    func fetchPreviousEvents() {
        guard let roomId = activeRoom.id else { return }
        
        isLoading.send(true)
        
        let request = ChatRequest.ListPreviousEvents(
            roomid: roomId,
            limit: 10
        )
        
        Session.manager.chatClient.listPreviousEvents(request) { (code, serverMessage, _, response) in
            self.isLoading.send(false)
            if code == 200 {
                guard let events = response?.events, events.count > 0 else { return }
                print(events.count)
                self.previousEvents.send(events)
            } else {
                guard let message = serverMessage else { return }
                self.errorMsg.send(message)
            }
        }
    }
}

extension RoomViewModel {
    private func haveActorsJoinThisRoom() {
        isLoading.send(true)
        
        Account.manager.systemActors.forEach {
            let request = ChatRequest.JoinRoom(
                roomid: activeRoom.id!,
                userid: $0.userId
            )
            
            Session.manager.chatClient.joinRoom(request) { (_, _, _, _) in
                self.isLoading.send(false)
            }
        }
    }
}
