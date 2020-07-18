//
//  RoomCell.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 5/30/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import SportsTalk247

class RoomCell: UITableViewCell {
    static let identifier = "RoomCell"
    static let nib = UINib(nibName: RoomCell.identifier, bundle: nil)
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomSummary: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet var circularComponents: [UIView]!
}

extension RoomCell {
    override func layoutSubviews() {
        circularComponents.forEach { $0.layer.cornerRadius = $0.frame.height / 2 }
        containerView.layer.cornerRadius = 10
    }
}

extension RoomCell {
    func configure(room: ChatRoom) {
        self.roomName.text = room.name ?? ""
        self.roomSummary.text = room.description
        self.population.text = "\(room.inroom ?? 0) fans inside"
    }
}
