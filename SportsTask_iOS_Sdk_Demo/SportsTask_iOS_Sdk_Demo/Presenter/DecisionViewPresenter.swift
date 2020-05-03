//
//  DecisionViewPresenter.swift
//  SportsTask_iOS_Sdk_Demo
//
//  Created by Admin on 02/05/20.
//  Copyright © 2020 krishna41. All rights reserved.
//

import Foundation
import SportsTalk_iOS_SDK

class  DecisionViewPresenter: NSObject{
    private var services: Services!
     init(services: Services) {
        self.services = services
         super.init()
        loadRooms()
        
    }
    
    func loadRooms(){
        CommonUttilities.shared.showLoader()
        services.ams.listRooms { (response) in
            let data = response["data"] as? [String:Any]
            let rooms = data?["rooms"] as? [[String:Any]]
            var roomExists = false
            for room in rooms ?? []{
                let isOpen =  room["open"] as? Bool ?? false
                if isOpen{
                    roomId = room["id"] as? String ?? ""
                    roomExists = true
                    break
                }
            }
            CommonUttilities.shared.hideLoader()
            if !roomExists{
                self.createRoom()
            }
        }
    }
    
    func createRoom(){
        let createRoom = ChatRoomsServices.CreateRoomPostmoderated()
        createRoom.name = "Test Room Post Moderated 3"
        createRoom.slug = "post-test-room-\(getDateTimeString())"
        createRoom.description = "Chat Room Newly Created"
        createRoom.enableactions = true
        createRoom.enableenterandexit = true
        createRoom.roomisopen = true
        createRoom.userid = userIds.first ?? ""
        CommonUttilities.shared.showLoader()
        services.ams.chatRoomsServices(createRoom) { (response) in
            let data = response["data"] as? [String:Any]
            roomId = data?["id"] as? String ?? ""
            CommonUttilities.shared.hideLoader()
        }
    }
    
    private func getDateTimeString() -> String{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let date = Date()
        return dateFormatter.string(from: date)
    }
}
