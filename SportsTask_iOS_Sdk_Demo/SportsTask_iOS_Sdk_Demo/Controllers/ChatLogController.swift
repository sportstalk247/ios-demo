import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    
    var user:User? {
        didSet {
            navigationItem.title = user?.name
            
            observeMessages()
        }
    }
    
//    override var inputAccessoryView: UIView? {
//        get {
//            let containerView = UIView()
//            containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//            containerView.backgroundColor = .white
//
//            let sendButton = UIButton(type: .system)
//            sendButton.setTitle("Send", for: .normal)
//            sendButton.translatesAutoresizingMaskIntoConstraints = false
//            sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
//            containerView.addSubview(sendButton)
//
//            sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
//            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//            sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
//            sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
//
//            containerView.addSubview(inputTextFields)
//
//            inputTextFields.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
//            inputTextFields.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//            inputTextFields.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
//            inputTextFields.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
//
//            let seperatorLineView = UIView()
//            seperatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
//            seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
//            containerView.addSubview(seperatorLineView)
//
//            seperatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
//            seperatorLineView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
//            seperatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//            seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
//
//
//            return containerView
//        }
//    }
    
//    override var canBecomeFirstResponder: Bool {
//        get {
//            return true
//        }
//    }
//
    lazy var inputTextFields: UITextField = {
        let inputTextFields = UITextField()
        inputTextFields.placeholder = "Enter message..."
        inputTextFields.translatesAutoresizingMaskIntoConstraints = false
        inputTextFields.text = "test test test"
        inputTextFields.delegate = self
//        inputTextFields.backgroundColor = .red
        return inputTextFields
    }()
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 50, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(ChatMesageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupInputComponents()
        setupKeyboardObserver()
    }
    
    func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(handleKeyboardWillShow),
        name: UIResponder.keyboardWillShowNotification,
        object: nil)
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(handleKeyboardWillhide),
        name: UIResponder.keyboardWillHideNotification,
        object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardWillShow(notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber {
            
            containerViewBottomAnchor?.constant = -keyboardSize.height
            
            UIView.animate(withDuration: animationDuration.doubleValue) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func handleKeyboardWillhide(notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber {
            
            containerViewBottomAnchor?.constant = (containerViewBottomAnchor?.constant ?? 0) + keyboardSize.height
            UIView.animate(withDuration: animationDuration.doubleValue) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat = 80
        
        if let text = messages[indexPath.item].text {
            height = extimatedFrameForText(text: text).height + 20
        }
        
        return .init(width: self.view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ChatMesageCell
        let message = messages[indexPath.row]

        cell?.textView.text = message.text
        cell?.bubbleWidthAnchor?.constant = extimatedFrameForText(text: message.text ?? "").width + 32
        
        if message.fromId == Auth.auth().currentUser?.uid {
            cell?.bubbleView.backgroundColor = ChatMesageCell.blueColor
            cell?.textView.textColor = .white
            cell?.profileImageVIew.image = nil
            cell?.bubbleViewRightAnchor?.isActive = true
            cell?.bubbleViewLeftAnchor?.isActive = false

        }
        else {
            cell?.bubbleView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
            cell?.textView.textColor = .black
            cell?.profileImageVIew.loadImageUsingCacheWithUrlString(urlString: user?.profileImageUrl ?? "")
            
            cell?.bubbleViewRightAnchor?.isActive = false
            cell?.bubbleViewLeftAnchor?.isActive = true
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func extimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let font = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: font, context: nil)
    }
    
    var messages = [Message]()
    
    func observeMessages() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let userMessagereference = Database.database().reference().child(User_Messages_Table).child(uid).child(user!.id!)
        
        userMessagereference.observe(.childAdded) { (snapshot) in
            let messageid = snapshot.key
            
            let messagereference = Database.database().reference().child(Messages_Table).child(messageid)

            messagereference.observeSingleEvent(of: .value) { (messageSnapShot) in
                if let dictionary = messageSnapShot.value as? [String:AnyObject] {
                 let message = Message()
                    message.setValuesForKeys(dictionary)
                    
//                    if message.chatPatnerId() == self.user?.id {
                        self.messages.append(message)
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
//                    }
                }
            }
        }
    }
    
    var containerViewBottomAnchor:NSLayoutConstraint?
    
    fileprivate func setupInputComponents() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(containerView)

        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerViewBottomAnchor?.isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputTextFields)
        
        inputTextFields.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextFields.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextFields.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextFields.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true

        let seperatorLineView = UIView()
        seperatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(seperatorLineView)
        
        seperatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        seperatorLineView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        seperatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    @objc func handleSend() {
        if inputTextFields.text != "" {
            firstTask { (messageId) -> Void in
                if messageId != "" {
                    self.inputTextFields.text = nil
                    
                    // do second task if success
                    let fromId = Auth.auth().currentUser?.uid ?? ""
                    let toId = self.user?.id ?? ""
                    
                    let userMessageReference = Database.database().reference().child(User_Messages_Table).child(fromId).child(toId)
                    userMessageReference.updateChildValues([messageId : 1])
                    
                    
                    let userMessageReferenceToId = Database.database().reference().child(User_Messages_Table).child(toId).child(fromId)
                    userMessageReferenceToId.updateChildValues([messageId : 1])
                }
            }
        }
    }
    
    func firstTask(completion: @escaping (_ messageId: String) -> Void) {
        let ref = Database.database().reference()
        let messageref = ref.child(Messages_Table)
        let childref = messageref.childByAutoId()
        let toId = user?.id ?? ""
        let fromId = Auth.auth().currentUser?.uid ?? ""
        let values = ["text":inputTextFields.text ?? "", "toId": toId, "fromId": fromId, "timeStamp": NSDate().timeIntervalSince1970] as [String : Any]
        
        childref.updateChildValues(values as [AnyHashable : Any])

        childref.updateChildValues(values) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            completion(childref.key ?? "")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        
        return true
    }
}
