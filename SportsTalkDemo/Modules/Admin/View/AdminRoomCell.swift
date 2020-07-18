//
//  AdminRoomCell.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/12/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import SportsTalk247

protocol AdminRoomCellDelegate: class {
    func delete(cell: AdminRoomCell, room: ChatRoom)
    func edit(cell: AdminRoomCell, room: ChatRoom)
}

class AdminRoomCell: UITableViewCell {
    static let identifier = "AdminRoomCell"
    static let nib = UINib(nibName: AdminRoomCell.identifier, bundle: nil)
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomSummary: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet var circularComponents: [UIView]!
    
    weak var delegate: AdminRoomCellDelegate?
    private var room: ChatRoom!
}

extension AdminRoomCell {
    override func layoutSubviews() {
        circularComponents.forEach { $0.layer.cornerRadius = $0.frame.height / 2 }
        containerView.layer.cornerRadius = 10
    }
}

// MARK: - Convenience
extension AdminRoomCell {
    func configure(room: ChatRoom) {
        self.room = room
        self.roomName.text = room.name ?? ""
        self.roomSummary.text = room.description
        self.population.text = "\(room.inroom ?? 0) fans inside"
    }
}

// MARK: Actions & Events
extension AdminRoomCell {
    @IBAction private func deleteButtonTapped() {
        delegate?.delete(cell: self, room: room)
    }
    
    @IBAction private func editButtonTapped() {
        delegate?.edit(cell: self, room: room)
    }
}
