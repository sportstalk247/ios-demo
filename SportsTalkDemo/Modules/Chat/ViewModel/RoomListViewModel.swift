//
//  RoomListViewModel.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 5/26/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import Combine
import SportsTalk247

class RoomListViewModel {
    let title = "Rooms"
    
    var cancellables = Set<AnyCancellable>()
    let rooms = CurrentValueSubject<[ChatRoom], Never>([])
    let selectedRoom = PassthroughSubject<ChatRoom, Never>()
    let isLoading = PassthroughSubject<Bool, Never>()
    let systemMessage = PassthroughSubject<String, Never>()
    
    init() {
        fetchRooms()
    }
}

extension RoomListViewModel {
    func fetchRooms() {
        let request = ChatRequest.ListRooms()
        self.isLoading.send(true)
        
        Session.manager.chatClient.listRooms(request) { [unowned self] (code, message, kind, response) in
            guard let rooms = response?.rooms else {
                self.isLoading.send(false)
                self.systemMessage.send(message != nil ? message! : "Something went wrong. Code \(String(describing: code))")
                return
            }
            
            self.rooms.send(rooms)
        }
    }
    
    func joinRoom(roomId: String) {
        let request = ChatRequest.JoinRoom()
        request.roomid = roomId
        request.userid = Account.manager.me!.userId
        
        isLoading.send(true)
        
        Session.manager.chatClient.joinRoom(request) { [unowned self] (code, message, kind, response) in
            if code == 200 {
                self.isLoading.send(false)
                guard let room = response?.room else { return }
                self.selectedRoom.send(room)
            } else {
                self.isLoading.send(false)
                self.systemMessage.send(message != nil ? message! : "Something went wrong. Code \(String(describing: code))")
            }
        }
    }
}
