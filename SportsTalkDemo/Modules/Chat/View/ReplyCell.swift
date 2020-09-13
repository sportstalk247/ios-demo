//
//  ReplyCell.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 8/1/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import MessageKit

class ReplyCell: MessageContentCell {
    static let identifier = "ReplyCell"
    
    lazy var originalMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .darkGray
        return label
    }()
    
    lazy var replyMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var originalContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        return view
    }()
    
    lazy var replyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        originalContainer.layer.cornerRadius = 15
        replyContainer.layer.cornerRadius = 15
    }
    
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        layoutAs(sender: message.sender)
        
        guard let dataSource = messagesCollectionView.messagesDataSource else {
            fatalError("MessageKitError.nilMessagesDataSource")
        }
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError("MessageKitError.nilMessagesDisplayDelegate")
        }

        delegate = messagesCollectionView.messageCellDelegate
        
        displayDelegate.configureAvatarView(avatarView, for: message, at: indexPath, in: messagesCollectionView)
        displayDelegate.configureAccessoryView(accessoryView, for: message, at: indexPath, in: messagesCollectionView)
        
        let topCellLabelText = dataSource.cellTopLabelAttributedText(for: message, at: indexPath)
        let bottomCellLabelText = dataSource.cellBottomLabelAttributedText(for: message, at: indexPath)
        let topMessageLabelText = dataSource.messageTopLabelAttributedText(for: message, at: indexPath)
        let bottomMessageLabelText = dataSource.messageBottomLabelAttributedText(for: message, at: indexPath)

        cellTopLabel.attributedText = topCellLabelText
        cellBottomLabel.attributedText = bottomCellLabelText
        messageTopLabel.attributedText = topMessageLabelText
        messageBottomLabel.attributedText = bottomMessageLabelText
        
        switch message.kind {
        case .custom(let data as [String: Any]):     
            guard
                let body = data["body"] as? String,
                let original = data["original"] as? String
            else { return }
            
            originalMessage.text = "\"\(original)\""
            replyMessage.text = body
        default:
            break
        }
    }
}

extension ReplyCell {
    private func layoutAs(sender: SenderType) {
        messageContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        messageContainerView.addSubview(originalContainer)
        messageContainerView.addSubview(replyContainer)
        
        originalContainer.addSubview(originalMessage)
        replyContainer.addSubview(replyMessage)
        
        NSLayoutConstraint.activate([
            originalMessage.topAnchor.constraint(equalTo: originalContainer.topAnchor, constant: 8),
            originalMessage.bottomAnchor.constraint(equalTo: originalContainer.bottomAnchor, constant: -8),
            originalMessage.leadingAnchor.constraint(equalTo: originalContainer.leadingAnchor, constant: 8),
            originalMessage.trailingAnchor.constraint(equalTo: originalContainer.trailingAnchor, constant: -8),
            
            replyMessage.topAnchor.constraint(equalTo: replyContainer.topAnchor, constant: 8),
            replyMessage.bottomAnchor.constraint(equalTo: replyContainer.bottomAnchor, constant: -8),
            replyMessage.leadingAnchor.constraint(equalTo: replyContainer.leadingAnchor, constant: 8),
            replyMessage.trailingAnchor.constraint(equalTo: replyContainer.trailingAnchor, constant: -8),
        ])
        
        if sender.senderId == Account.manager.me?.userId {
            NSLayoutConstraint.activate([
                originalContainer.topAnchor.constraint(equalTo: messageContainerView.topAnchor),
                originalContainer.leadingAnchor.constraint(greaterThanOrEqualTo: messageContainerView.leadingAnchor),
                originalContainer.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor),
                
                replyContainer.topAnchor.constraint(equalTo: originalContainer.bottomAnchor, constant: -6),
                replyContainer.leadingAnchor.constraint(greaterThanOrEqualTo: messageContainerView.leadingAnchor),
                replyContainer.trailingAnchor.constraint(equalTo: originalContainer.trailingAnchor, constant: -10),
                replyContainer.bottomAnchor.constraint(lessThanOrEqualTo: messageContainerView.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                originalContainer.topAnchor.constraint(equalTo: messageContainerView.topAnchor),
                originalContainer.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor),
                originalContainer.trailingAnchor.constraint(lessThanOrEqualTo: messageContainerView.trailingAnchor),
                
                replyContainer.topAnchor.constraint(equalTo: originalContainer.bottomAnchor, constant: -6),
                replyContainer.leadingAnchor.constraint(equalTo: originalContainer.leadingAnchor, constant: 10),
                replyContainer.trailingAnchor.constraint(lessThanOrEqualTo: messageContainerView.trailingAnchor),
                replyContainer.bottomAnchor.constraint(lessThanOrEqualTo: messageContainerView.bottomAnchor)
            ])
        }
    }
}
