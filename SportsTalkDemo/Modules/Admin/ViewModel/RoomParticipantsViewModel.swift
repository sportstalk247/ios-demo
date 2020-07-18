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
    let systemMessage = PassthroughSubject<String, Never>()
    
    init(room: ChatRoom) {
        self.room = room
        self.title = "\(room.name!) fans"
    }
}

// MARK: - Convenience
extension RoomParticipantsViewModel {
    func fetchInhabitants() {
        guard let roomId = room.id else {
            return
        }
        
        isLoading.send(true)
        
        let request = ChatRequest.ListRoomParticipants()
        request.roomid = roomId
        
        Session.manager.chatClient.listRoomParticipants(request) { (code, message, _, response) in
            self.isLoading.send(false)
            guard let response = response else { return }
            self.participants.send(response.participants)
        }
    }
    
    func makeAnnouncement(_ text: String) {
        let request = ChatRequest.ExecuteChatCommand()
        request.customtype = "announcement"
        request.command = text
        request.userid = "admin"
        request.roomid = room.id
        
        self.isLoading.send(true)
        
        Session.manager.chatClient.executeChatCommand(request) { [unowned self] (code, _, _, _) in
            self.isLoading.send(false)
            
            if code == 200 {
                self.systemMessage.send("Successfully posted an announcement.")
            } else {
                self.systemMessage.send("Failed to post an announcement.")
            }
        }
    }
    
    private func makeBanChatStatus(for actor: Actor, banned: Bool) {
        let request = ChatRequest.ExecuteChatCommand()
        request.customtype = "announcement"
        request.command = "\(actor.displayName) has been \(banned ? "banned" : "unbanned") by admin"
        request.userid = "admin"
        request.roomid = room.id
        
        Session.manager.chatClient.executeChatCommand(request) { (code, _, _, _) in
            if code == 200 {
                // success
            }
        }
    }
    
    func ban(actor: Actor) {
        let request = UserRequest.setBanStatus()
        request.userid = actor.userId
        request.banned = true
        
        isLoading.send(true)
        
        Session.manager.userClient.setBanStatus(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.fetchInhabitants()
                self.makeBanChatStatus(for: actor, banned: true)
                self.isLoading.send(false)
            }
        }
    }
    
    func unban(actor: Actor) {
        let request = UserRequest.setBanStatus()
        request.userid = actor.userId
        request.banned = false
        
        isLoading.send(true)
        
        Session.manager.userClient.setBanStatus(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.fetchInhabitants()
                self.makeBanChatStatus(for: actor, banned: false)
                self.isLoading.send(false)
            }
        }
    }
    
    func delete(actor: Actor) {
        // Note: When deleting test accounts, some test actors may try to come back to life.
        // Reset the simulation when this happens
        
        let request = UserRequest.DeleteUser()
        request.userid = actor.userId
        
        isLoading.send(true)
        
        Session.manager.userClient.deleteUser(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.fetchInhabitants()
                self.isLoading.send(false)
            }
        }
    }
}


