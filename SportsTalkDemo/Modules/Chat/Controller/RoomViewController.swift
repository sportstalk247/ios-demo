//
//  RoomViewViewController.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/6/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import Combine
import Toast_Swift
import SportsTalk247
import MBProgressHUD
import MessageKit
import MessageInputBar
import InputBarAccessoryView

class RoomViewController: MessagesViewController {
    
    var viewModel: RoomViewModel!
    var messages = [Message]()
    var timer: Timer?
    var isReplyingTo: Message?
    
    override var inputAccessoryView: UIView? {
        return messageInputBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.newEvents.send([])
        messagesCollectionView.reloadData()
        viewModel.fetchParticipants()
    }

    override func viewDidLoad() {
        messagesCollectionView = MessagesCollectionView(frame: .zero, collectionViewLayout: SystemMessagesFlowLayout())
        messagesCollectionView.register(SystemCell.self)
        messagesCollectionView.register(ReplyCell.self)
        
        super.viewDidLoad()
        setupView()
        setupReactive()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }

        guard !isSectionReservedForTypingIndicator(indexPath.section) else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }

        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        if case .custom(let data as [String: Any]) = message.kind {
            guard let type = data["type"] as? EventType else {
                return super.collectionView(collectionView, cellForItemAt: indexPath)
            }
            
            switch type {
            case .announcement, .action:
                let cell = messagesCollectionView.dequeueReusableCell(SystemCell.self, for: indexPath)
                cell.configure(with: message, at: indexPath, and: messagesCollectionView)
                return cell
            case .reply:
                let cell = messagesCollectionView.dequeueReusableCell(ReplyCell.self, for: indexPath)
                cell.configure(with: message, at: indexPath, and: messagesCollectionView)
                return cell
            default:
                break
            }
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

// MARK: - Convenience
extension RoomViewController {
    private func setupView() {
        navigationItem.title = viewModel.activeRoom.name
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "car.fill"), style: .plain, target: self, action: #selector(self.exitButtonPressed))
        navigationItem.leftBarButtonItem = backButton
        
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(self.profileButtonPressed))
        navigationItem.rightBarButtonItem = profileButton
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        
        // We will be using MessageInputBar's topStack as reply indicator
        messageInputBar.topStackView.alignment = .center
        messageInputBar.topStackView.distribution = .fill
        messageInputBar.delegate = self
        
        guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else {
            return
        }

        layout.setMessageIncomingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout.setMessageIncomingAccessoryViewPadding(HorizontalEdgeInsets(left: 8, right: 0))
        layout.setMessageIncomingAccessoryViewPosition(.messageTop)
        layout.setMessageOutgoingAccessoryViewSize(CGSize(width: 30, height: 30))
        layout.setMessageOutgoingAccessoryViewPadding(HorizontalEdgeInsets(left: 0, right: 8))
    }
    
    private func setupReactive() {
        Publishers
            .CombineLatest(Account.manager.$me, viewModel.participants)
            .receive(on: RunLoop.main)
            .sink { [unowned self] (me, participants) in
                for participant in participants {
                    guard let user = participant.user else { return }
                    let actor = Actor(from: user)
                    actor.saveLocally()
                }
                
                if me != nil && !participants.isEmpty {
                    // Modify message for name changes
                    let myMessages = self.messages.filter({ $0.sender.senderId == me!.userId })
                    
                    myMessages.forEach { message in
                        message.sender = me!
                    }
                    
                    self.viewModel.startListening()
                    self.startActing()
                } else {
                    self.stopActing()
                    self.messages = []
                    self.messagesCollectionView.reloadData()
                    Session.manager.chatClient.stopListeningToChatUpdates()
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            .store(in: &viewModel.cancellables)
        
        viewModel
            .newEvents
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [unowned self] newEvents in
                newEvents.forEach { event in
                    if event.user != nil {
                        guard event.eventtype != nil else { return }
                        guard let body = event.body, !body.isEmpty else { return }
                        self.messages.append(Message(from: event))
                    } else {
                        guard let eventId = event.parentid else { return }
                        let changables = self.messages.filter({ $0.messageId == eventId })
                        
                        changables.forEach { message in
                            message.body = "(deleted)"
                        }
                    }
                }
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel
            .reactedEvent
            .receive(on: RunLoop.main)
            .sink { [unowned self] event in
                
                if let event = event.replyto, let eventId = event.id {
                    let reactedMessages = self.messages.filter { $0.messageId == eventId }
                    
                    for message in reactedMessages {
                        message.reactions = event.reactions
                    }
                }
                
                self.messagesCollectionView.reloadData()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel
            .isLoading
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [unowned self] loading in
                if loading {
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
            .store(in: &viewModel.cancellables)
        
        viewModel
            .errorMsg
            .receive(on: RunLoop.main)
            .sink { message in
                self.view.makeToast(message, duration: 1.0, position: .center)
            }
            .store(in: &viewModel.cancellables)
    }
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return messages[indexPath.section].actor == messages[indexPath.section - 1].actor
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section + 1 < messages.count else { return false }
        return messages[indexPath.section].actor == messages[indexPath.section + 1].actor
    }
}

// MARK: Actions & Events
extension RoomViewController {
    @objc private func exitButtonPressed() {
        viewModel.exitRoom { success in
            DispatchQueue.main.async {
                if success {
                    self.stopActing()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.view.makeToast("Unable to exit room.")
                }
            }
        }
    }
    
    @objc private func profileButtonPressed() {
        performSegue(withIdentifier: Segue.User.presentUserProfile, sender: self)
    }
    
    @objc private func startActing() {
        // Exclude admin from acting
        let actors = Account.manager.systemActors.filter { $0.userId != "admin" }
        
        guard actors.count > 0 else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            let randomActor = actors[Int.random(in: 0 ..< actors.count)]
            let speak = randomActor.speakWithRandomIntent()
            randomActor.sendMessage(to: self.viewModel.activeRoom, with: speak)
        })
    }
    
    @objc private func stopActing() {
        timer?.invalidate()
    }
    
    @objc private func cancelReply() {
        isReplyingTo = nil
        messageInputBar.topStackView.subviews.forEach { $0.removeFromSuperview() }
        messageInputBar.inputTextView.text = String()
    }
}

// MARK: - Navigation
extension RoomViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.User.presentUserProfile {
            if let destination = segue.destination as? UserProfileTableViewController {
                guard let actor = Account.manager.me else { return }
                destination.viewModel = UserProfileViewModel(actor: actor)
            }
        }
    }
}

// MARK: - Delegate Methods
// MARK: MessageKit
extension RoomViewController: MessagesDataSource, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return Account.manager.me!
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if let avatar = Account.manager.avatarForActor(message.sender) {
            avatarView.set(avatar: avatar)
        }
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        var corners: UIRectCorner = []
        if isFromCurrentSender(message: message) {
            corners.formUnion(.topLeft)
            corners.formUnion(.bottomLeft)
            if !isPreviousMessageSameSender(at: indexPath) {
                corners.formUnion(.topRight)
            }
            if !isNextMessageSameSender(at: indexPath) {
                corners.formUnion(.bottomRight)
            }
        } else {
            corners.formUnion(.topRight)
            corners.formUnion(.bottomRight)
            if !isPreviousMessageSameSender(at: indexPath) {
                corners.formUnion(.topLeft)
            }
            if !isNextMessageSameSender(at: indexPath) {
                corners.formUnion(.bottomLeft)
            }
        }
        
        return .custom { view in
            let radius: CGFloat = 16
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            view.layer.mask = mask
        }
    }
    
    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        accessoryView.subviews.forEach { $0.removeFromSuperview() }
        accessoryView.backgroundColor = .clear
        
        if let m = messageForItem(at: indexPath, in: messagesCollectionView) as? Message {
            guard m.deleted == false else { return }
        }
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.tintColor = .darkGray
        button.frame = accessoryView.bounds
        
        button.isUserInteractionEnabled = false

        accessoryView.addSubview(button)
        accessoryView.layer.cornerRadius = accessoryView.frame.height / 2
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if !isPreviousMessageSameSender(at: indexPath) {
            var name = message.sender.displayName
            
            if let m = messageForItem(at: indexPath, in: messagesCollectionView) as? Message {
                if m.type == .custom {
                    name += " (unknown message type)"
                }
            }
            
            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
                NSAttributedString.Key.foregroundColor: UIColor.darkGray
            ]
            return NSAttributedString(string: name, attributes: attributes)
        }
        return nil
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        return NSAttributedString(string: "Reply", attributes: attributes)
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        guard let message = message as? Message else { return nil }
        guard let reactions = message.reactions else { return nil }
        
        guard let reaction = reactions.filter({ $0.type == "like" }).first else { return nil }
        guard let count = reaction.count else { return nil }
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        let liked = reactions.contains { $0.type == "like" }
        
        return liked ? NSAttributedString(string: "👍 x\(count)", attributes: attributes) : nil
    }
}

extension RoomViewController: MessagesLayoutDelegate {
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return !isPreviousMessageSameSender(at: indexPath) ? 20 : 0
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        guard let message = message as? Message else { return 0 }
        guard let reactions = message.reactions else { return 0 }
        
        let liked = reactions.contains { $0.type == "like" }
        let deleted = message.deleted
        
        if deleted {
            return 0
        } else {
            return liked ? 20 : 0
        }
    }
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if let m = messageForItem(at: indexPath, in: messagesCollectionView) as? Message {
            return m.deleted ? 0 : 20
        }
        return 20
    }
}

// MARK: MessageCellDelegate
extension RoomViewController: MessageCellDelegate {
    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }

        guard let message = messageForItem(at: indexPath, in: messagesCollectionView) as? Message else {
            return
        }
        
        guard message.deleted == false else { return }
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let like = UIAlertAction(title: "Like", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.sendLike(to: message.messageId, at: indexPath)
        }
        sheet.addAction(like)
        
        if message.type != .custom {
            let report = UIAlertAction(title: "Report", style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.report(message, at: indexPath)
            }
            sheet.addAction(report)
        }
        
        if sheet.actions.count > 0 {
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            sheet.addAction(cancel)
            
            present(sheet, animated: true, completion: nil)
        }
    }
    
    func didTapCellBottomLabel(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }
        
        if let message = messageForItem(at: indexPath, in: messagesCollectionView) as? Message {
            messageInputBar.topStackView.subviews.forEach { $0.removeFromSuperview() }
            
            let text = "Replying to \(message.actor.displayName)'s message. cancel"
            let label = UILabel()
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 10)
            label.text = text
            let underlineAttriString = NSMutableAttributedString(string: text)
            let range1 = (text as NSString).range(of: "cancel")
            underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 10), range: range1)
            underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range1)
            label.attributedText = underlineAttriString
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.cancelReply)))

            messageInputBar.topStackView.addArrangedSubview(label)
            
            isReplyingTo = message
        }
        messageInputBar.inputTextView.becomeFirstResponder()
    }
}

// MARK: MessageInputBar
extension RoomViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        for component in inputBar.inputTextView.components {
            if let message = component as? String {
                if let replyingToMessage = isReplyingTo {
                    viewModel.sendReply(message, to: replyingToMessage)
                } else {
                    viewModel.sendMessage(message)
                }
            }
        }
        
        isReplyingTo = nil
        
        inputBar.topStackView.subviews.forEach { $0.removeFromSuperview() }
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom(animated: true)
    }
}
