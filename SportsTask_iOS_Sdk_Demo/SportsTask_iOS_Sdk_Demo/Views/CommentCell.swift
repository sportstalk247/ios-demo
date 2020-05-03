import Foundation
import UIKit

class CommentCell: UICollectionViewCell{
    var presenter: CommentsViewPresenter!
    var model: Comment!{
        didSet{
            if let user = model.user{
                if let picture = user.pictureurl, !picture.isEmpty{
                    imageView.clipsToBounds = true
                    imageView.layer.cornerRadius = 20
                    imageView.contentMode = .scaleAspectFill
                    imageView.loadImageUsingCacheWithUrlString(urlString: picture)
                    
                }else{
                    imageView.image = UIImage(systemName: "person.circle")
                    imageView.clipsToBounds = false
                    imageView.layer.cornerRadius = 0
                    imageView.contentMode = .scaleAspectFit
                }
                name.text = user.handle
            }
            if presenter.isAlreadyLiked(model: model){
                like.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            }else{
                like.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            }
            
            if presenter.isAlreadyReported(model: model){
                report.setImage(UIImage(systemName: "exclamationmark.shield.fill"), for: .normal)
            }else{
                report.setImage(UIImage(systemName: "exclamationmark.shield"), for: .normal)
            }
            
            message.text = model.body
        }
    }
    
    @objc func reportComment(_ sender: UIButton){
        presenter?.reportComment(model: model)
        
    }
    
    @objc func likeComment(_ sender: UIButton){
        presenter?.likeComment(model: model)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        super.prepareForReuse()
    }
    
    func setup(){
        backgroundColor = .white
        [imageView,name,divider1,message,divider2,stackView].forEach{contentView.addSubview($0)}
        report.addTarget(self, action: #selector(reportComment(_:)), for: .touchUpInside)
        like.addTarget(self, action: #selector(likeComment(_:)), for: .touchUpInside)
        setupConstrains()
    }
    
    func setupConstrains(){
        
        let c = contentView
        
        let constraints = [
             
            imageView.topAnchor.constraint(equalTo: c.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: c.leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            name.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10),
            name.trailingAnchor.constraint(equalTo: c.trailingAnchor, constant: -10),
            
            divider1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            divider1.leadingAnchor.constraint(equalTo: c.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: c.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            message.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 10),
            message.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            message.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            
            divider2.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 4),
            divider2.leadingAnchor.constraint(equalTo: c.leadingAnchor),
            divider2.trailingAnchor.constraint(equalTo: c.trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.topAnchor.constraint(equalTo: divider2.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: c.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: c.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: c.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public let imageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(systemName: "person.circle")
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let name: UILabel = {
        let v = UILabel()
        v.text = "Label Text"
        v.textColor = .black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let divider1: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let message: UILabel = {
        let v = UILabel()
        v.text = "Label Text"
        v.textColor = .black
        v.font = UIFont.systemFont(ofSize: 16)
        v.numberOfLines = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let divider2: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 241, g: 241, b: 241)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let like: UIButton = {
        let v = UIButton(type: .system)
        v.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        v.setTitle("  Like", for: .normal)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let report: UIButton = {
        let v = UIButton(type: .system)
        v.setImage(UIImage(systemName: "exclamationmark.shield"), for: .normal)
        v.setTitle("  Report", for: .normal)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [like,report])
        v.alignment = .fill
        v.axis = .horizontal
        v.spacing = 8
        v.distribution = .fillEqually
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
}
