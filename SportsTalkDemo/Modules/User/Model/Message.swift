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

class Message: MessageType {
    var messageId: String
    var actor: Actor
    var sentDate: Date
    var kind: MessageKind
    var sender: SenderType
    var body: String?
    var reactions: [ChatEventReaction]?
    
    init(from event: SportsTalk247.Event) {
        messageId = event.id!
        actor = Account.manager.locallyFetchActor(with: event.userid!)!
        sentDate = event.ts!
        sender = actor
        body = event.body
        reactions = event.reactions
        
        if event.eventtype == .action {
            kind = .custom(event.body)
        } else if event.eventtype == .reply {
            if let reply = event.body {
                if let original = event.replyto?.body {
                    kind = .text("\"\(original)\"\n\(reply)")
                } else {
                    kind = .text(reply)
                }
            } else {
                kind = .custom(nil)
            }
        } else if event.eventtype == .reaction {
            kind = .custom(nil)
        } else if event.eventtype == .announcement || event.customtype == "announcement" {
            guard let body = event.body else {
                kind = .custom(event.body)
                return
            }
            kind = .custom("📢 \(body)")
        } else {
            if let text = event.body {
                kind = .text(text)
            } else {
                kind = .custom(nil)
            }
        }
    }
}
