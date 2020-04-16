import UIKit

class ChatLogViewController: BaseCollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout
{
    let cellId = "cellId"
   
    private var presenter: ChatLogViewPresenter!
        
    lazy var inputTextFields: UITextField = {
        let inputTextFields = UITextField()
        inputTextFields.placeholder = "Enter message..."
        inputTextFields.translatesAutoresizingMaskIntoConstraints = false
        inputTextFields.delegate = self

        return inputTextFields
    }()
    
    override func viewDidLoad() {
        setup()
        
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 50, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(ChatMesageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupInputComponents()
        setupKeyboardObserver()
        
        setupNavBarAWithUser(user: selectedUser)
    }
    
    func setup()
    {
        presenter = ChatLogViewPresenter(view: self, services: services)
        presenter.loadData()
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
        presenter.gettingDismissed()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardWillShow(notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber {
            
            containerViewBottomAnchor?.constant = -keyboardSize.height
            
            UIView.animate(withDuration: animationDuration.doubleValue)
            {
                self.view.layoutIfNeeded()
                self.moveCollectionvieToEnd()
            }
        }
    }
    
    @objc func handleKeyboardWillhide(notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber {
            
            containerViewBottomAnchor?.constant = (containerViewBottomAnchor?.constant ?? 0) + keyboardSize.height
            UIView.animate(withDuration: animationDuration.doubleValue)
            {
                self.view.layoutIfNeeded()
                self.moveCollectionvieToEnd()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupNavBarAWithUser(user:User?) {
        guard let user = user else { return }
        self.navigationItem.title = user.handle

        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        titleView.backgroundColor = .red
        
        let profileImageView = UIImageView()
        profileImageView.loadImageUsingCacheWithUrlString(urlString: user.getUrlString())
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.layer.masksToBounds = true
        titleView.addSubview(profileImageView)
        
        
        profileImageView.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.isUserInteractionEnabled = true
        
        let nameLabel = UILabel()
        nameLabel.text = user.handle
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(nameLabel)

        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        navigationItem.titleView = titleView
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat = 80
        let message = presenter.messages[indexPath.item]
        
        if let text = message.body
        {
            height = extimatedFrameForText(text: text).height + 20
        }
        
        if message.body == "advertisement" || message.body == "GOAL"
        {
              height = 150
        }
        
        return .init(width: self.view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ChatMesageCell
        let message = presenter.messages[indexPath.row]

        cell?.textView.text = message.body
        cell?.bubbleWidthAnchor?.constant = extimatedFrameForText(text: message.body ?? "").width + 32
        cell?.delegate = self
        cell?.indexpath = indexPath
        
        // Check Message Like
        
        let likeCount = presenter.likeCount(message: message)
                
        if likeCount > 0
        {
//            cell?.likeButton.setTitle("@@@\(likeCount)", for: .normal)
            cell?.likeLabel.text = "\(likeCount)"
            cell?.likeButton.tintColor = .green
        }
        else
        {
            cell?.likeLabel.text = "0"
            cell?.likeButton.tintColor = .gray
            cell?.likeButton.setTitle("", for: .normal)
        }
        
        if message.user?.userid == selectedUser?.userid
        {
            cell?.bubbleView.backgroundColor = ChatMesageCell.blueColor
            cell?.textView.textColor = .white
            cell?.profileImageVIew.image = nil
            cell?.bubbleViewRightAnchor?.isActive = true
            cell?.bubbleViewLeftAnchor?.isActive = false
            
            cell?.likeButtonforLeftContainer?.isActive = false
            cell?.likeButtonforRightContainer?.isActive = true
  
            cell?.likeLabelforLeftContainer?.isActive = false
            cell?.likeLabelforRightContainer?.isActive = true
        }
        else
        {
            cell?.bubbleView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
            cell?.textView.textColor = .black
            cell?.profileImageVIew.loadImageUsingCacheWithUrlString(urlString: message.user?.getUrlString() ?? "")
            
            cell?.bubbleViewRightAnchor?.isActive = false
            cell?.bubbleViewLeftAnchor?.isActive = true
            
            cell?.likeButtonforLeftContainer?.isActive = true
            cell?.likeButtonforRightContainer?.isActive = false

            cell?.likeLabelforLeftContainer?.isActive = true
            cell?.likeLabelforRightContainer?.isActive = false

        }
        
        if message.body == "advertisement" || message.body == "GOAL"
        {
            let imageUrlString = "https:\(parseQueryString(message.custompayload)?["img"] ?? "")"

            cell?.textView.text = ""
            cell?.dataImageView.loadImageUsingCacheWithUrlString(urlString: imageUrlString)
            cell?.dataImageView.isHidden = false
            cell?.bubbleView.isHidden = true
            
            cell?.bubbleWidthAnchor?.constant = 150
        }
        else
        {
            cell?.bubbleView.isHidden = false
            cell?.dataImageView.isHidden = true
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func parseQueryString(_ query: String?) -> [AnyHashable : Any]? {
        var dict: [AnyHashable : Any] = [:]
        let pairs = query?.components(separatedBy: ",")
        
        for pair in pairs ?? [] {
            let comp = pair.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
            let comp1 = comp.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
            let comp2 = comp1.replacingOccurrences(of: "}", with: "", options: NSString.CompareOptions.literal, range: nil)
            let comp3 = comp2.replacingOccurrences(of: "{", with: "", options: NSString.CompareOptions.literal, range: nil)
            let elements = comp3.components(separatedBy: ":")
            let key = elements[0].removingPercentEncoding ?? ""
            let val = elements.last?.removingPercentEncoding
            
            dict[key] = val
        }
        
        return dict
    }
    
    func extimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let font = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: font, context: nil)
    }
        
    var containerViewBottomAnchor:NSLayoutConstraint?
    var sendButton = UIButton(type: .system)
    
    fileprivate func setupInputComponents()
    {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(containerView)

        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerViewBottomAnchor?.isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        sendButton = UIButton(type: .system)
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
    
    @objc func handleSend()
    {
        if inputTextFields.text != ""
        {
            sendButton.isUserInteractionEnabled = false
            presenter.sendMessage(message: inputTextFields.text ?? "") {
                self.dispatchMain
                {
                    self.sendButton.isUserInteractionEnabled = true
                    self.inputTextFields.text = ""
                }
            }
        }
    }
    
    func moveCollectionvieToEnd()
    {
        let item = self.collectionView(self.collectionView, numberOfItemsInSection: 0) - 1
        let lastItemIndex = NSIndexPath(item: item, section: 0)
        self.collectionView.scrollToItem(at: lastItemIndex as IndexPath, at: .top, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        handleSend()
        
        textField.text = ""

        return true
    }
    
    var _isCollectionViewLoading = false
}

extension ChatLogViewController: ChatLogView
{
    var isCollectionViewLoading: Bool
    {
        get
        {
            return _isCollectionViewLoading
        }
        set
        {
            _isCollectionViewLoading = newValue
        }
    }
    
    func refresh(_ firstTimeMakeUserToBottom: Bool = false)
    {
        dispatchMain{
                self.collectionView.reloadData()
            if firstTimeMakeUserToBottom
            {
                self.moveCollectionvieToEnd()
            }
        }
    }

    func insertRowsAtIndexes(indexpaths: [IndexPath])
    {
        dispatchMain
        {
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: indexpaths)
            }) { (status) in }
        }
    }
}

extension ChatLogViewController: ChatMesageCellView
{
    func likeMessage(indexPath: IndexPath, cell: UICollectionViewCell)
    {
        if let cell = cell as? ChatMesageCell
        {
            cell.likeButton.isUserInteractionEnabled = false
            
            presenter.likeButtonPress(index: indexPath.item)
            {
                self.dispatchMain
                {
                    cell.likeButton.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    func refreshRowAt(indexpath: IndexPath)
    {
        dispatchMain
        {
            self.collectionView.reloadItems(at: [indexpath])
        }
    }
}
