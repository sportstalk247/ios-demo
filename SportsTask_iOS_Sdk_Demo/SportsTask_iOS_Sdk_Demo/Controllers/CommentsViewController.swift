import Foundation
import UIKit
class CommentsViewController: BaseViewController{
    
    var presenter: CommentsViewPresenter!
    var adapter: CommentsViewControllerAdapter?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comments"
        setup()
    }
    
    func setup(){
        view.backgroundColor = .white
        setupViews()
        presenter = CommentsViewPresenter(services: services, view: self)
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        collectionView.keyboardDismissMode = .interactive
    }
    
    func setupViews(){
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 50, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: "CommentCell")
        
        view.addSubview(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        setupInputComponents()
        setupKeyboardObserver()
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override var inputAccessoryView: UIView?{
        return UIView()
    }
    
    
    @objc private func didPullToRefresh(_ sender: Any) {
        presenter.loadData(isRefreshing: true)
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
            
            UIView.animate(withDuration: animationDuration.doubleValue)
            {
                 self.view.superview?.layoutIfNeeded()
//                self.moveCollectionvieToEnd()
            }
        }
    }
    
    @objc func handleKeyboardWillhide(notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber {
            
            containerViewBottomAnchor?.constant = (containerViewBottomAnchor?.constant ?? 0) + keyboardSize.height
            UIView.animate(withDuration: animationDuration.doubleValue)
            {
                self.view.superview?.layoutIfNeeded()
//                self.moveCollectionvieToEnd()
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
    
    @objc func handleSend(_ sender: UIButton){
        print("Called")
        if !inputTextFields.text.trim.isEmpty && inputTextFields.textColor != UIColor.lightGray{
            sendButton.isEnabled = false
            presenter.sendComment(text: inputTextFields.text.trim)
        }
        
        if inputTextFields.text.trim.isEmpty{
            clearInput()
        }
    }
    func moveCollectionvieToEnd(){
        if !presenter.array.isEmpty{
            let index = presenter.array.count - 1
            self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .top, animated: true)
        }
        
    }
}

extension CommentsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend(sendButton)
        return true
    }
}
extension CommentsViewController: CommentsView{
    
    func updateRow(index: Int, isNew: Bool) {
        dispatchMain {
            if isNew{
                self.collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
                self.moveCollectionvieToEnd()
            }else{
                self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
        }
    }
    
    func showData() {
        dispatchMain {
            self.adapter = nil
            self.adapter = CommentsViewControllerAdapter(presenter: self.presenter)
            self.collectionView.delegate = self.adapter
            self.collectionView.dataSource = self.adapter
            self.refreshControl.endRefreshing()
        }
    }
    
    func messageSent(success: Bool){
        dispatchMain {
            self.sendButton.isEnabled = true
            if success{
                self.clearInput()
            }
        }
    }
    func clearInput(){
        self.view.endEditing(true)
        self.inputTextFields.text = nil
        self.textViewDidChange(self.inputTextFields)
        self.textViewDidEndEditing(self.inputTextFields)
    }
}
extension CommentsViewController: UITextViewDelegate{
    
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
extension CommentsViewController{
    class CommentsViewControllerAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        
        let presenter: CommentsViewPresenter!
        
        init(presenter: CommentsViewPresenter) {
            self.presenter = presenter
            super.init()
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return presenter?.array.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCell
            cell.presenter = presenter
            cell.model = presenter?.array[indexPath.item]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var height: CGFloat = 100 // minimum height
            if presenter.array.indices.contains(indexPath.item){
                let model = presenter.array[indexPath.item]
                if !model.body.isEmpty{
                    height += estimatedFrameForText(text: model.body, width: collectionView.frame.width - 20).height + 20
                }
            }
            return CGSize(width: collectionView.frame.width, height: height)
        }
        
        private func sizeWithLayoutManager(text: String, font: UIFont, maxSize: CGSize) -> CGSize {
            let textContainer = NSTextContainer(size: maxSize)
            let layoutManager = NSLayoutManager()
            let attributedStering = replicateAttributedStringSetByUITextView(text: text, font: font, color: UIColor.black)
            let textStorage = NSTextStorage(attributedString: attributedStering)
            textContainer.lineFragmentPadding = 10
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
        
        func estimatedFrameForText(text: String, width: CGFloat) -> CGSize {
            
            return sizeWithLayoutManager(text: text, font: UIFont.systemFont(ofSize: 16), maxSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        }
    }
}
