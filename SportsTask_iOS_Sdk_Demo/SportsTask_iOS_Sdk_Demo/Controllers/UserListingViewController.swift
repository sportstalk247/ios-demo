import UIKit

class UserListingViewController: BaseViewController
{
    private var tableViewCellHeight = CGFloat(70)
    
    private var tableView: UITableViewBase!
    private var presenter: UserListingViewPresenter!
    
    var isDestinationConversation = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        setup()
        
        // Register the cells.
        UserCell.configuration.register(tableView: tableView)
    }
    
    func setup()
    {
        title = "Pick a demo user"
        
        presenter = UserListingViewPresenter(view: self, services: services)
        
        setupControls()
        setupConstraints()
        
        dispatchBackground
        {
            self.presenter.loadUsersDetail()
        }
    }
    
    func setupControls()
    {
        tableView = UITableViewBase()
        tableView.setup
        {
            $0.delegate = self
            $0.dataSource = self
            view.addSubview($0)
        }
    }
    
    func setupConstraints()
    {
        tableView.safeAnchorConstraints(left: view.safeAreaLayoutGuide.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}

extension UserListingViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return presenter.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let ret = UserCell.configuration.dequeue(tableView: tableView)
        {
            ret.load(indexPath: indexPath, presenter: presenter)
            
            return ret
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedUser = presenter.users[indexPath.item]

        if isDestinationConversation{
            let vc = CommentConversationsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let chatLogController = ChatLogViewController()
            self.navigationController?.pushViewController(chatLogController, animated: true)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserListingViewController: UserListingView{
    func refresh()
    {
        dispatchMain
        {
            self.tableView.reloadData()
        }
    }
}

extension UserListingViewController
{
    class UserCell: UITableViewCellBase
    {
        static let configuration = CellConfiguration<UserCell>()

        // Constants
        private let labelLeftSpace = CGFloat(15)
        private let imageSize = CGFloat(50)
        private let imageCornerRadius = CGFloat(25)

        // Controls
        private var userImage: UIImageViewBase!
        private var userNameLabel: UILabelBase!

        // Properties
        private var presenter: UserListingViewPresenter?

        override func setup()
        {
            super.setup()

            setupControls()
            setupConstraints()
        }

        func load(indexPath: IndexPath, presenter: UserListingViewPresenter)
        {
            self.presenter = presenter
            
            let user = presenter.users[indexPath.row]
            if let picture = user.pictureurl, !picture.isEmpty{
                self.userImage.loadImageUsingCacheWithUrlString(urlString: picture)
            }else{
                let imageurl = user.getUrlString()
                self.userImage.loadImageUsingCacheWithUrlString(urlString: imageurl)
            }
            self.userNameLabel.text = user.handle
        }

        private func setupConstraints()
        {
            userImage?.anchorConstraints(left: contentView.layoutMarginsGuide.leftAnchor)
            userImage.alignCenterConstraints(centerY: contentView.layoutMarginsGuide.centerYAnchor)
            userImage?.sizeConstraints(height: imageSize, width: imageSize)
            userNameLabel.anchorConstraints(left: userImage.rightAnchor, leftConstant: labelLeftSpace, top: userImage.topAnchor, right: contentView.layoutMarginsGuide.rightAnchor, bottom: userImage.bottomAnchor)
        }

        private func setupControls()
        {
            userImage = UIImageViewBase()
            userImage.setup
            {
                $0.backgroundColor = .black
                $0.layer.cornerRadius = imageCornerRadius

                contentView.addSubview($0)
            }
            
            userNameLabel = UILabelBase()
            userNameLabel.setup
            {
                contentView.addSubview($0)
            }
        }
    }
}
