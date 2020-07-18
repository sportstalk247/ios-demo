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
    let isLoading = PassthroughSubject<Bool, Never>()
    let shouldReload = PassthroughSubject<IndexPath, Never>()
    let errorMsg = PassthroughSubject<String, Never>()
    
    var activeRoom: ChatRoom
    
    init(room: ChatRoom) {
        self.activeRoom = room
        self.haveActorsJoinThisRoom()
    }
}

extension RoomViewModel {
    func exitRoom(completion: @escaping (_ success: Bool) -> Void) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }
        
        let request = ChatRequest.ExitRoom()
        request.roomid = roomId
        request.userid = userId
        
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
            
            // Hijack empty string sent by me. Happens when like
            events.removeAll { (event) -> Bool in
                
                if event.userid == Account.manager.me?.userId {
                    if let body = event.body {
                        return body.isEmpty
                    } else {
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
        
        let request = ChatRequest.ExecuteChatCommand()
        request.roomid = roomId
        request.userid = userId
        request.command = message
        
        Session.manager.chatClient.executeChatCommand(request) { (code, message, _, response) in
            if code == 200 {
                // Success
            } else {
                guard let message = message else { return }
                self.errorMsg.send(message)
            }
        }
    }
    
    func sendReply(_ reply: String, to message: Message) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }
        
        let request = ChatRequest.SendQuotedReply()
        request.roomid = roomId
        request.userid = userId
        request.replyto = message.messageId
        request.command = reply
        
        Session.manager.chatClient.sendQuotedReply(request) { (code, _, kind, response) in
            if code == 200 {
                // Success
            }
        }
    }
    
    func sendLike(to messageId: String, at indexPath: IndexPath) {
        guard
            let roomId = activeRoom.id,
            let userId = Account.manager.me?.userId
        else {
            return
        }
        
        let request = ChatRequest.ReactToEvent()
        request.userid = userId
        request.eventid = messageId
        request.roomid = roomId
        request.reaction = "like"
        request.reacted = "true"
        
        Session.manager.chatClient.reactToEvent(request) { (code, message, _, response) in
            if code == 200 {
                self.shouldReload.send(indexPath)
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
        
        let request = ChatRequest.ReportMessage()
        request.chat_room_newest_speech_id = message.messageId
        request.chatRoomId = roomId
        request.userid = userId
        
        Session.manager.chatClient.reportMessage(request) { (code, serverMessage, _, reponse) in
            if code == 200 {
                self.errorMsg.send("\(message.actor.name)'s message has been reported.")
            } else {
                guard let message = serverMessage else { return }
                self.errorMsg.send(message)
            }
        }
    }
}

extension RoomViewModel {
    private func haveActorsJoinThisRoom() {
        guard
            let eugene = Account.manager.eugene,
            let vincent = Account.manager.vincent,
            let alfred = Account.manager.alfred,
            let dennis = Account.manager.dennis
        else {
            return
        }
        
        isLoading.send(true)
        
        [eugene, vincent, alfred, dennis].forEach {
            let request = ChatRequest.JoinRoom()
            request.roomid = activeRoom.id!
            request.userid = $0.userId
            
            Session.manager.chatClient.joinRoom(request) { (_, _, _, _) in
                self.isLoading.send(false)
            }
        }
    }
}
