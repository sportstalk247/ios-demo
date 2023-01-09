//
//  AddEditRoomViewModel.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/12/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import Combine
import SportsTalk247

class AddEditRoomViewModel {
    var cancellables = Set<AnyCancellable>()
    let isLoading = PassthroughSubject<Bool, Never>()
    let message = PassthroughSubject<String, Never>()
    
    var selectedRoom: ChatRoom?
    
    var name: String?
    var summary: String?
    var customId: String?
    var enableRoomActions = true
    var enableProfanityFilter = true
    var enableEnterAndExit = true
    var isOpen = true

    init(room: ChatRoom?) {
        self.selectedRoom = room
        self.name = selectedRoom?.name
        self.summary = selectedRoom?.description
        self.customId = selectedRoom?.customid
        self.enableRoomActions = selectedRoom?.enableactions ?? true
        self.enableProfanityFilter = selectedRoom?.enableprofanityfilter ?? true
        self.enableEnterAndExit = selectedRoom?.enableenterandexit ?? true
        self.isOpen = selectedRoom?.open ?? true
    }
}

extension AddEditRoomViewModel {
    func createRoom(completion: @escaping (_ success: Bool) -> ()) {
        isLoading.send(true)
        
        guard let name = name, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            isLoading.send(false)
            message.send("Room name is required.")
            return
        }
        
        let request = ChatRequest.CreateRoom()
        request.name = name
        request.description = summary
        request.customid = customId
        request.enableactions = enableRoomActions
        request.enableprofanityfilter = enableProfanityFilter
        request.enableenterandexit = enableEnterAndExit
        request.roomisopen = isOpen
        
        Session.manager.chatClient.createRoom(request) { [unowned self] (code, message, _, _) in
            if code == 200 {
                
            } else {
                if let message = message {
                    self.message.send(message)
                }
            }
            
            completion(code == 200)
        }
    }
    
    func editRoom(completion: @escaping (_ success: Bool) -> ()) {
        isLoading.send(true)
        
        guard let roomId = selectedRoom?.id else {
            isLoading.send(true)
            message.send("Room name is required.")
            return
        }
        
        guard let name = name, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            isLoading.send(false)
            message.send("Room name is required.")
            return
        }
        
        let request = ChatRequest.UpdateRoom(
            roomid: roomId,
            name: name,
            description: summary,
            customid: customId,
            enableactions: enableRoomActions,
            enableenterandexit: enableEnterAndExit,
            enableprofanityfilter: enableProfanityFilter,
            roomisopen: isOpen
        )
        
        Session.manager.chatClient.updateRoom(request) { [unowned self] (code, message, _, room) in
            guard code == 200 else {
                if let message = message {
                    self.message.send(message)
                }
                completion(false)
                return
            }
            
            completion(true)
        }
    }
}
