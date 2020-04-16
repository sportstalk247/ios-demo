import UIKit

protocol ChatMesageCellView
{
    func likeMessage(indexPath: IndexPath, cell: UICollectionViewCell)
}

class ChatMesageCell: UICollectionViewCell {
    
    static let blueColor = UIColor(r: 0, g: 137, b: 249)
    var delegate: ChatMesageCellView?
    var indexpath: IndexPath?
    
    let profileImageVIew:UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let textView: UITextView = {
       let tv = UITextView()
        tv.text = "somerandomsomerandomsomerandom text"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = .clear
        tv.textColor = .white
        tv.isUserInteractionEnabled = false
        
        return tv
    }()
    
    let dataImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.layer.cornerRadius = 5
        iv.isHidden = true
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let bubbleView: UIView = {
       let view = UIView()
        view.backgroundColor = ChatMesageCell.blueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    let likeLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.text = "0"
        likeLabel.translatesAutoresizingMaskIntoConstraints = false

        return likeLabel
    }()
    
    @objc func handleButton()
    {
        guard let indexpath = indexpath else { return }
        delegate?.likeMessage(indexPath: indexpath, cell: self)
    }
    
    var bubbleWidthAnchor:NSLayoutConstraint?
    var bubbleViewRightAnchor:NSLayoutConstraint?
    var bubbleViewLeftAnchor:NSLayoutConstraint?
    var likeButtonforLeftContainer: NSLayoutConstraint?
    var likeButtonforRightContainer: NSLayoutConstraint?
    
    var likeLabelforLeftContainer: NSLayoutConstraint?
    var likeLabelforRightContainer: NSLayoutConstraint?


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageVIew)
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(dataImageView)
        addSubview(likeButton)
        addSubview(likeLabel)
        
        likeButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
        profileImageVIew.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageVIew.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        profileImageVIew.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageVIew.heightAnchor.constraint(equalToConstant: 32).isActive = true

        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        bubbleViewRightAnchor?.isActive = true
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageVIew.rightAnchor, constant: 8)
        bubbleViewLeftAnchor?.isActive = false
        bubbleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        dataImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        dataImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dataImageView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        dataImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true

        likeButtonforLeftContainer = likeButton.leftAnchor.constraint(equalTo: bubbleView.rightAnchor)
        likeButtonforLeftContainer?.isActive = true
        likeButtonforRightContainer = likeButton.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: -30)
        likeButtonforRightContainer?.isActive = false
        
        let likeButtonwidthAnchor = likeButton.widthAnchor.constraint(equalToConstant: 30)
            likeButtonwidthAnchor.isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        
        likeLabelforLeftContainer = likeLabel.leftAnchor.constraint(equalTo: likeButton.leftAnchor, constant: likeButtonwidthAnchor.constant)
        likeLabelforLeftContainer?.isActive = true
        likeLabelforRightContainer = likeLabel.leftAnchor.constraint(equalTo: likeButton.leftAnchor, constant: -likeButtonwidthAnchor.constant)
        likeLabelforRightContainer?.isActive = false

//        likeLabel.bottomAnchor.constraint(equalTo: likeButton.bottomAnchor).isActive = true
        likeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
        likeLabel.widthAnchor.constraint(equalToConstant: 15).isActive = true
        likeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true

    }
    
    override func prepareForReuse() {
        profileImageVIew.image = nil
        super.prepareForReuse()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
