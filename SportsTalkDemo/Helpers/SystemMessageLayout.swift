//
//  SystemMessageLayout.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/28/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation
import MessageKit
import SportsTalk247

open class SystemMessagesFlowLayout: MessagesCollectionViewFlowLayout {
    
    open lazy var customMessageSizeCalculator = CustomMessageSizeCalculator(layout: self)
    
    open override func cellSizeCalculatorForItem(at indexPath: IndexPath) -> CellSizeCalculator {
        if isSectionReservedForTypingIndicator(indexPath.section) {
            return typingIndicatorSizeCalculator
        }
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        if case .custom = message.kind {
            return customMessageSizeCalculator
        }
        return super.cellSizeCalculatorForItem(at: indexPath)
    }
    
    open override func messageSizeCalculators() -> [MessageSizeCalculator] {
        var superCalculators = super.messageSizeCalculators()
        // Append any of your custom `MessageSizeCalculator` if you wish for the convenience
        // functions to work such as `setMessageIncoming...` or `setMessageOutgoing...`
        superCalculators.append(customMessageSizeCalculator)
        return superCalculators
    }
}

open class CustomMessageSizeCalculator: MessageSizeCalculator {
    
    public override init(layout: MessagesCollectionViewFlowLayout? = nil) {
        super.init()
        self.layout = layout
    }
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message)
        switch message.kind {
        case .custom(let data as [String: Any]):
            guard let type = data["type"] as? EventType else { break }
            guard let body = data["body"] as? String else { break }
            
            switch type {
            case .announcement:
                let font = UIFont.systemFont(ofSize: 13)
                let attributes = [NSAttributedString.Key.font: font]
                
                let body = body as NSString
                let rect = body.boundingRect(with: CGSize(width: maxWidth, height: 2000), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: rect.width, height: rect.height)
            case .reply:
                let font = UIFont.systemFont(ofSize: 16)
                let attributes = [NSAttributedString.Key.font: font]
                
                let body = body as NSString
                let bodyRect = body.boundingRect(with: CGSize(width: maxWidth, height: 2000), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                let bodyHeight = bodyRect.height <= 44 ? 44 : bodyRect.height
                
                guard let original = data["original"] as? String else {
                    return CGSize(width: bodyRect.width + messageContainerPadding(for: message).left + messageContainerPadding(for: message).right, height: bodyHeight)
                }
                
                let originalRect = original.boundingRect(with: CGSize(width: maxWidth, height: 2000), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                
                let width = (bodyRect.width > originalRect.width ? bodyRect.width : originalRect.width) + messageContainerPadding(for: message).left + messageContainerPadding(for: message).right
                
                return CGSize(width: width, height: bodyHeight + 44)
            default:
                break
            }
        default:
            break
        }

        return CGSize(width: maxWidth, height: 44)
    }
}
