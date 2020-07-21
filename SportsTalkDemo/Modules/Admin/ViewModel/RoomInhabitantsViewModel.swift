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
    
    var cancellables = Set<AnyCancellable>()
    var participants = CurrentValueSubject<[ChatRoomParticipant], Never>([ChatRoomParticipant]())
    let isLoading = PassthroughSubject<Bool, Never>()
    
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
        
        Client.Chat.listRoomParticipants(request) { (code, message, _, response) in
            self.isLoading.send(false)
            
            guard let response = response else { return }
            response.participants.forEach { print("\($0.user?.displayname) is \($0.user?.banned)\n") }
            self.participants.send(response.participants)
        }
    }
    
    func ban(actor: Actor) {
        let request = UserRequest.setBanStatus()
        request.userid = actor.userId
        request.banned = true
        
        isLoading.send(true)
        
        Client.User.setBanStatus(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.fetchInhabitants()
                self.isLoading.send(false)
            }
        }
    }
    
    func unban(actor: Actor) {
        let request = UserRequest.setBanStatus()
        request.userid = actor.userId
        request.banned = false
        
        isLoading.send(true)
        
        Client.User.setBanStatus(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.fetchInhabitants()
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
        
        Client.User.deleteUser(request) { (_, _, _, _) in
            // Chaining api calls might cause reponse to be outdated. add 2 seconds delay to be safe
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.fetchInhabitants()
                self.isLoading.send(false)
            }
        }
    }
}


