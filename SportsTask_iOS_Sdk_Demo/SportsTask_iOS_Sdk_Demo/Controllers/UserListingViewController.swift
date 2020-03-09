import UIKit

class UserListingViewController: BaseViewController
{
    private var tableViewCellHeight = CGFloat(70)
    
    private var tableView: UITableViewBase!
    private var presenter: UserListingViewPresenter!
    var loader = MBProgressHUD()
    
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
        
        self.loader = MBProgressHUD(view: self.view)
        self.view.addSubview(self.loader)
    }
    
    func setupConstraints()
    {
        _ = tableView.safeAnchorConstraints(left: view.safeAreaLayoutGuide.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
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

        let chatLogController = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(chatLogController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserListingViewController: UserListingView
{
    func startLoader()
    {
        dispatchMain
        {
            self.loader.show(animated: true)
        }
    }
    
    func stopLoader()
    {
        dispatchMain
        {
            self.loader.hide(animated: true)
        }
    }
    
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
            let imageurl = user.getUrlString() 
            
            self.userImage.loadImageUsingCacheWithUrlString(urlString: imageurl)
            self.userNameLabel.text = user.handle
        }

        private func setupConstraints()
        {
            _ = userImage?.anchorConstraints(left: contentView.layoutMarginsGuide.leftAnchor)
            _ = userImage.alignCenterConstraints(centerY: contentView.layoutMarginsGuide.centerYAnchor)
            _ = userImage?.sizeConstraints(height: imageSize, width: imageSize)
            
            _ = userNameLabel.anchorConstraints(left: userImage.rightAnchor, leftConstant: labelLeftSpace, top: userImage.topAnchor, right: contentView.layoutMarginsGuide.rightAnchor, bottom: userImage.bottomAnchor)
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
