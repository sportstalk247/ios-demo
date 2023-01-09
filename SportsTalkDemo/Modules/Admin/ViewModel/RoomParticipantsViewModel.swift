//
//  RoomInhabitantsViewModel.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/14/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import Combine
import SportsTalk247

class RoomParticipantsViewModel {
    var title: String!
    var room: ChatRoom!
    var selectedActor: Actor?
    
    var cancellables = Set<AnyCancellable>()
    var participants = CurrentValueSubject<[ChatRoomParticipant], Never>([ChatRoomParticipant]())
    let isLoading = PassthroughSubject<Bool, Never>()
    let message = PassthroughSubject<String, Never>()
    
    init(room: ChatRoom) {
        self.room = room
        self.title = "\(room.name!) fans"
    }
}

// MARK: - Convenience
extension RoomParticipantsViewModel {
    func getRoomDetails() {
        guard let roomId = room.id else { return }
        
        isLoading.send(true)
        
        let request = ChatRequest.GetRoomDetails(
            roomid: roomId
        )

        Session.manager.chatClient.getRoomDetails(request) { (code, message, _, response) in
            self.isLoading.send(false)
            
            if code == 200, let newRoom = response {
                self.room = newRoom
            } else {
                if let message = message {
                    self.message.send(message)
                } else {
                    self.message.send("Failed to get room details.")
                }
            }
        }
    }
    
    func fetchParticipants() {
        guard let roomId = room.id else {
            return
        }
        
        isLoading.send(true)
        
        let request = ChatRequest.ListRoomParticipants(
            roomid: roomId
        )
        
        Session.manager.chatClient.listRoomParticipants(request) { (code, message, _, response) in
            self.isLoading.send(false)
            guard let response = response else { return }
            self.participants.send(response.participants)
            self.getRoomDetails()
        }
    }
    
    func makeAnnouncement(_ text: String) {
        let request = ChatRequest.ExecuteChatCommand(
            roomid: room.id!,
            command: text,
            userid: "admin",
            eventtype: .announcement
        )
        
        self.isLoading.send(true)
        
        do {
            try Session.manager.chatClient.executeChatCommand(request) { [unowned self] (code, message, _, _) in
                self.isLoading.send(false)
                
                if code == 200 {
                    self.message.send("Successfully posted an announcement.")
                } else {
                    if let message = message {
                        self.message.send(message)
                    } else {
                        self.message.send("Failed to post an announcement.")
                    }
                }
            }
        } catch {
            print("RoomParticipantsViewModel::makeAnnouncement() -> error = \(error.localizedDescription)")
        }
    }
    
    private func makeBanChatStatus(for actor: Actor, banned: Bool) {
        let request = ChatRequest.ExecuteChatCommand(
            roomid: room.id!,
            command: "\(actor.displayName) has been \(banned ? "banned" : "unbanned") by admin",
            userid: "admin",
            eventtype: .announcement
        )
        
        do {
            try Session.manager.chatClient.executeChatCommand(request) { (code, _, _, _) in
                if code == 200 {
                    // success
                }
            }
        } catch {
            print("RoomParticipantsViewModel::makeBanChatStatus() -> error = \(error.localizedDescription)")
        }
    }
    
    func ban(actor: Actor) {
        let request = UserRequest.SetBanStatus(
            userid: actor.userId,
            applyeffect: true
        )
        
        isLoading.send(true)
        
        Session.manager.userClient.setBanStatus(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.fetchParticipants()
                self.makeBanChatStatus(for: actor, banned: true)
                self.isLoading.send(false)
            }
        }
    }
    
    func unban(actor: Actor) {
        let request = UserRequest.SetBanStatus(
            userid: actor.userId,
            applyeffect: false
        )
        
        isLoading.send(true)
        
        Session.manager.userClient.setBanStatus(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.fetchParticipants()
                self.makeBanChatStatus(for: actor, banned: false)
                self.isLoading.send(false)
            }
        }
    }
    
    func delete(actor: Actor) {
        if Account.manager.systemActors.map({ $0.userId }).contains(where: { $0 == actor.userId }) {
            message.send("Error - You are removing a system generated actor. Please remove a valid user")
            return
        }
        
        isLoading.send(true)
        
        let request = UserRequest.DeleteUser(
            userid: actor.userId
        )
        
        Session.manager.userClient.deleteUser(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                actor.deleteLocally()
                self.fetchParticipants()
                self.isLoading.send(false)
            }
        }
    }
    
    func purge(actor: Actor) {
        let request = ChatRequest.PurgeUserMessages(
            roomid: room.id!,
            userid: actor.userId,
            handle: actor.handle,
            password: systemPassword
        )
        
        Session.manager.chatClient.purgeMessage(request) { (code, serverMesssage, _, response) in
            if code == 200 {
                self.message.send("\(actor.handle)'s messages has been purged.")
            } else {
                guard let message = serverMesssage else { return }
                self.message.send(message)
            }
        }
    }
    
    func deleteAll(actor: Actor) {
        let request = ChatRequest.DeleteAllEvents(
            roomid: room.id!,
            userid: actor.userId,
            password: systemPassword
        )
        
        Session.manager.chatClient.deleteAllEvents(request) { (code, serverMessage, _, response) in
            if code == 200 {
                self.message.send("All of \(actor.handle)'s messages has been deleted.")
            } else {
                guard let message = serverMessage else { return }
                self.message.send(message)
            }
        }
    }
    
    func bounce(_ flag: Bool, actor: Actor) {
        let request = ChatRequest.BounceUser(
            roomid: room.id!,
            userid: actor.userId,
            bounce: flag
        )
    
        if flag {
            request.announcement = "\(actor.handle) has been bounced from this room."
        } else {
            request.announcement = "\(actor.handle) is no longer bounced from this room."
        }
        
        
        Session.manager.chatClient.bounceUser(request) { (code, serverMessage, _, response) in
            if code == 200 {
                guard let announcement = request.announcement else { return }
                self.makeAnnouncement(announcement)
                self.message.send("Success")
                self.getRoomDetails()
            } else {
                guard let message = serverMessage else { return }
                self.message.send(message)
            }
        }
    }
}


