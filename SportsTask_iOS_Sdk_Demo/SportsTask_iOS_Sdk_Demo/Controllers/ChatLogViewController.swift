import UIKit

class ChatLogViewController: BaseViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let cellId = "cellId"
   
    private var presenter: ChatLogViewPresenter!
        
    lazy var inputTextFields: UITextView = {
        let inputTextFields = UITextView()
        inputTextFields.text = placeholderText
        inputTextFields.textColor = UIColor.lightGray
        inputTextFields.font = UIFont.systemFont(ofSize: 16)
        inputTextFields.translatesAutoresizingMaskIntoConstraints = false
        inputTextFields.delegate = self

        return inputTextFields
    }()
    
    let containerView = UIView()
    
    lazy var collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           layout.minimumLineSpacing = 10
           layout.minimumInteritemSpacing = 10
           let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
           v.translatesAutoresizingMaskIntoConstraints = false
           v.backgroundColor = UIColor(r: 249, g: 249, b: 249)
           return v
       }()
    
    override func viewDidLoad() {
        setup()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)

        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromSafeArea
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 50, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(ChatMesageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.keyboardDismissMode = .interactive
        setupInputComponents()
        setupKeyboardObserver()
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
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
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override var inputAccessoryView: UIView?{
        return UIView()
    }
    
    @objc func handleKeyboardWillShow(notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber {
            
            containerViewBottomAnchor?.constant = -keyboardSize.height
            
            UIView.animate(withDuration: animationDuration.doubleValue)
            {
                self.view.superview?.layoutIfNeeded()
                self.moveCollectionvieToEnd()
            }
        }
    }
    
    @objc func handleKeyboardWillhide(notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber {
            
            containerViewBottomAnchor?.constant = (containerViewBottomAnchor?.constant ?? 0) + keyboardSize.height
            UIView.animate(withDuration: animationDuration.doubleValue)
            {
                self.view.superview?.layoutIfNeeded()
                self.moveCollectionvieToEnd()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
        super.viewWillTransition(to: size, with: coordinator)
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
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        
        return .init(width: collectionView.frame.width, height: height)
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ChatMesageCell
        let message = presenter.messages[indexPath.row]

        cell?.textView.text = message.body
        cell?.bubbleWidthAnchor?.constant = extimatedFrameForText(text: message.body ?? "").width + 22
        cell?.delegate = self
        cell?.indexpath = indexPath

        let likeCount = presenter.likeCount(message: message)
        print("Index: \(indexPath.item)\nLikecount \(likeCount)")
        if likeCount > 0
        {
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
            cell?.bubbleViewLeftAnchor?.isActive = false
            cell?.bubbleViewRightAnchor?.isActive = true
            
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
            
            cell?.likeButtonforRightContainer?.isActive = false
            cell?.likeButtonforLeftContainer?.isActive = true
            
            cell?.likeLabelforRightContainer?.isActive = false
            cell?.likeLabelforLeftContainer?.isActive = true
            

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
    
    private func sizeWithLayoutManager(text: String, font: UIFont, maxSize: CGSize) -> CGSize {
        let textContainer = NSTextContainer(size: maxSize)
        let layoutManager = NSLayoutManager()
        let attributedStering = replicateAttributedStringSetByUITextView(text: text, font: font, color: UIColor.black)
        let textStorage = NSTextStorage(attributedString: attributedStering)
        textContainer.lineFragmentPadding = 0
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        return layoutManager.usedRect(for: textContainer).size
    }
    
    private func replicateAttributedStringSetByUITextView(text: String, font: UIFont, color: UIColor) -> NSTextStorage {
        let attributes: [NSAttributedString.Key : Any] = [
            .font: font,
            .foregroundColor: color,
        ]
        let textStorage = NSTextStorage(string: text, attributes: attributes)
        return textStorage
    }
    
    func extimatedFrameForText(text: String) -> CGSize {
        return sizeWithLayoutManager(text: text, font: UIFont.systemFont(ofSize: 16), maxSize: CGSize(width: 200, height: CGFloat.greatestFiniteMagnitude))
    }
        
    var containerViewBottomAnchor:NSLayoutConstraint?
    var sendButton = UIButton(type: .system)
    
    fileprivate func setupInputComponents()
    {

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
        inputTextFields.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextFields.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        inputTextFields.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

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
        if inputTextFields.text != "" && inputTextFields.textColor != UIColor.lightGray
        {
            sendButton.isEnabled = false
            presenter.sendMessage(message: inputTextFields.text.trim) {
                self.dispatchMain
                {
                    self.sendButton.isEnabled = true
                    self.clearInput()
                }
            }
        }else{
            self.clearInput()
        }
    }
    
    func clearInput(){
        self.inputTextFields.text = nil
        self.textViewDidChange(self.inputTextFields)
        self.textViewDidEndEditing(self.inputTextFields)
        self.view.endEditing(true)
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
    func dismiss() {
        super.close()
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
extension ChatLogViewController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        containerView.constraints.forEach({
            if $0.firstAttribute == .height{
                if estimatedSize.height < 50 {
                    $0.constant = 50
                }else if estimatedSize.height > 80{
                    $0.constant = 80
                }else{
                    $0.constant = estimatedSize.height
                }
            }
        })
    }
}
