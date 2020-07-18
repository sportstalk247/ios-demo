//
//  AdminRoomsViewModel.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/12/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import Combine
import SportsTalk247

class AdminRoomsViewModel {
    let title = "Rooms"
    
    var cancellables = Set<AnyCancellable>()
    let rooms = CurrentValueSubject<[ChatRoom], Never>([])
    let isLoading = CurrentValueSubject<Bool, Never>(false)
    
    var selectedRoom: ChatRoom?
}

extension AdminRoomsViewModel {
    func fetchRooms() {
        let request = ChatRequest.ListRooms()
        
        Session.manager.chatClient.listRooms(request) { [unowned self] (code, message, kind, response) in
            guard let rooms = response?.rooms else {
                return
            }
            
            self.rooms.send(rooms)
        }
    }
    
    func deleteRoom(room: ChatRoom, completion: @escaping (_ success: Bool) -> () ) {
        selectedRoom = room
        
        let request = ChatRequest.DeleteRoom()
        request.roomid = room.id

        isLoading.send(true)
        
        Session.manager.chatClient.deleteRoom(request) { [unowned self] (code, message, kind, response) in
            self.isLoading.send(false)
            completion(code == 200)
        }
    }
}
