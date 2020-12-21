//
//  Message.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/6/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import SportsTalk247
import MessageKit

class Message: MessageType, Equatable {
    var messageId: String
    var actor: Actor
    var sentDate: Date
    var kind: MessageKind
    var type: EventType
    var sender: SenderType
    var body: String?
    var deleted: Bool = false
    var reactions: [ChatEventReaction]?
    
    init(from event: SportsTalk247.Event) {
        guard let user = event.user else {
            fatalError("No user")
        }
        
        messageId = event.id!
        sentDate = event.ts!
        type = event.eventtype ?? .custom
        body = event.body
        reactions = event.reactions
        actor = Actor(from: user)
        sender = actor
        deleted = event.deleted ?? false
        
        switch type {
        case .action:
            guard let body = event.body, !body.isEmpty else {
                kind = .custom(nil)
                return
            }
            kind = .custom(["type": EventType.action, "body": body])
        case .reply, .quoted:
            if let body = body, !body.isEmpty {
                if let original = event.replyto?.body, !original.isEmpty {
                    kind = .custom(["type": EventType.reply, "body": body, "original": original])
                    return
                }
            }
            kind = .custom(nil)
        case .reaction:
            kind = .custom(nil)
        case .announcement:
            guard let body = event.body, !body.isEmpty else {
                kind = .custom(nil)
                return
            }
            kind = .custom(["type": EventType.announcement, "body": "📢 \(body)"])
        case .custom:
            guard let body = event.body, !body.isEmpty else {
                kind = .custom(nil)
                return
            }
            kind = .text(body)
        default:
            guard let body = event.body, !body.isEmpty else {
                kind = .custom(nil)
                return
            }
            kind = .text(body)
        }
    }
    
    public static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.messageId == rhs.messageId    }
}
