//
//  ActorScript.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/6/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import SportsTalk247

// Messaging
enum Intent {
    case statement
    case question
    case opinion
    case expression(Expression)
    case confusion
    
    enum Expression {
        case happy
        case sad
        case offensive
        case exciting
    }
}

struct Speak {
    var intent: Intent
    var message: String
    
    init(intent: Intent = .statement, message: String) {
        self.intent = intent
        self.message = message
    }
}

struct ActorScript {
    static let statements: [Speak] = [
        Speak(message: "I agree."),
        Speak(intent: .opinion, message: "I don't believe you."),
        Speak(message: "I disagree"),
        Speak(intent: .question, message: "Really?"),
        Speak(intent: .expression(.exciting), message: "Great!"),
    ]
    
    static let question: [Speak] = [
        Speak(intent: .question, message: "How's it going?"),
        Speak(intent: .question, message: "Anyone of you guys a regular?"),
        Speak(intent: .question, message: "Is anyone here from Croatia?"),
        Speak(intent: .question, message: "Want some chicken?"),
        Speak(intent: .question, message: "How old are you guys?"),
        Speak(intent: .question, message: "How cool is that?"),
        Speak(intent: .question, message: "Are you serious?")
    ]
    
    static let opinion: [Speak] = [
        Speak(intent: .opinion, message: "I think it's you guys are not too bright."),
        Speak(intent: .opinion, message: "I believe the children are our future"),
        Speak(intent: .opinion, message: "Earth is NOT flat - it's a triangle"),
        Speak(intent: .opinion, message: "The main reason why we're suffering is we don't buy enough donuts."),
        Speak(intent: .opinion, message: "What makes this country so dang great is the bicycles."),
        Speak(intent: .opinion, message: "With the world going into shambles, the thing we need the most is more paragraphs on loren ipsum."),
        Speak(intent: .opinion, message: "Children should be answer to the law like adults."),
        Speak(intent: .opinion, message: "This room have some really nice people."),
        Speak(intent: .opinion, message: "Indian Scout Boober > any Harley Davidson bike. Fact!"),
        Speak(intent: .opinion, message: "Chicken tastes like chicken."),
        Speak(intent: .opinion, message: "The last play was meh."),
        Speak(intent: .opinion, message: "My team is the best team in the world.")
    ]


    static let confusion: [Speak] = [
        Speak(message: "I don't get it."),
        Speak(message: "Uhm..."),
        Speak(message: "Hmmm..."),
        Speak(message: "You lost me"),
    ]
}

extension Actor {
    func speakWith(intent: Intent) -> Speak {
        switch intent {
        case .statement:
            return ActorScript.statements[Int.random(in: 0 ..< ActorScript.statements.count)]
        default:
            return ActorScript.confusion[Int.random(in: 0 ..< ActorScript.confusion.count)]
        }
    }
    
    func speakWithRandomIntent() -> Speak {
        let intents = [ActorScript.statements,
                       ActorScript.confusion,
                       ActorScript.question,
                       ActorScript.opinion]
        
        let speak = intents[Int.random(in: 0 ..< intents.count)]
        return speak[Int.random(in: 0 ..< speak.count)]
    }
    
    func reaplyWithRandomIntent(to message: Message) -> Speak {
        let intents = [ActorScript.statements,
                       ActorScript.confusion,
                       ActorScript.question]
        
        let speak = intents[Int.random(in: 0 ..< intents.count)]
        return speak[Int.random(in: 0 ..< speak.count)]
    }
    
    func sendMessage(to room: ChatRoom, with message: Speak) {
        guard let roomId = room.id else { return }
        
        let request = ChatRequest.ExecuteChatCommand(
            roomid: roomId,
            command: message.message,
            userid: self.userId
        )
        
        do {
            try Session.manager.chatClient.executeChatCommand(request) { (code, message, _, response) in
                if code == 200 {
                    // Success
                }
            }
        } catch {
            print("Actor::sendMessage() -> error = \(error.localizedDescription)")
        }
    }
}
