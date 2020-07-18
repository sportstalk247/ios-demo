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
    
    var name: String?
    var description: String?
    var customId: String?
    var enableRoomActions = true
    var enableProfanityFilter = true
    var enableEnterAndExit = true
    var isOpen = true

}

extension AddEditRoomViewModel {
    func createRoom(completion: @escaping (_ success: Bool) -> ()) {
        isLoading.send(true)
        
        guard let name = name else {
            isLoading.send(true)
            message.send("Room name is required.")
            return
        }
        
        let request = ChatRequest.CreateRoom()
        request.name = name
        request.description = description
        request.customid = customId
        request.enableactions = enableRoomActions
        request.enableprofanityfilter = enableProfanityFilter
        request.enableenterandexit = enableEnterAndExit
        request.roomisopen = isOpen
        
        Client.Chat.createRoom(request) { [unowned self] (code, message, _, _) in
            if let message = message {
                self.message.send(message)
            }
            
            completion(code == 200)
        }
    }
}
