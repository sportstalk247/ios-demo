//
//  ParticipantsCell.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/14/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit

class ParticipantsCell: UITableViewCell {
    static let identifier = "ParticipantsCell"
    static let nib = UINib(nibName: ParticipantsCell.identifier, bundle: nil)
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var banView: UIView!
    
    @IBOutlet var circularComponents: [UIView]!
}

// MARK: -
extension ParticipantsCell {
    override func layoutSubviews() {
        circularComponents.forEach { $0.layer.cornerRadius = $0.frame.height / 2 }
    }
}

// MARK: - Convenience
extension ParticipantsCell {
    func configure(actor: Actor) {
        if let url = actor.photoURL {
            photo.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.fill"))
        }
        
        name.text = actor.name
        handle.text = actor.handle
        banView.isHidden = !actor.banned
    }
}

// MARK: Actions & Events
extension ParticipantsCell {}

