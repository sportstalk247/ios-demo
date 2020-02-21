import UIKit

class ChatMesageCell: UICollectionViewCell {
    
    static let blueColor = UIColor(r: 0, g: 137, b: 249)
    
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
    
    var bubbleWidthAnchor:NSLayoutConstraint?
    var bubbleViewRightAnchor:NSLayoutConstraint?
    var bubbleViewLeftAnchor:NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageVIew)
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(dataImageView)
        
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
        
//        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
//        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
                dataImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
                dataImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
                dataImageView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        //        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
                dataImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
