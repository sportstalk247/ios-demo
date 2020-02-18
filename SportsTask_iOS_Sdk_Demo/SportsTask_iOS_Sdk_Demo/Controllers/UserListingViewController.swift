import UIKit

class UserListingViewController: BaseViewController
{
    var tableView: UITableViewBase!
    
    private var presenter: UserListingViewPresenter!
    
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
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserListingViewController: UserListingView
{
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
        private let cornerRadius = CGFloat(5)
        private let spacing = CGFloat(8)

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
            _ = userImage?.anchorConstraints(left: contentView.layoutMarginsGuide.leftAnchor, leftConstant: 0)
            _ = userImage.alignCenterConstraints(centerY: contentView.layoutMarginsGuide.centerYAnchor)
            _ = userImage?.sizeConstraints(height: 50, width: 50)
            
            _ = userNameLabel.anchorConstraints(left: userImage.rightAnchor, leftConstant: 15, top: userImage.topAnchor, right: contentView.layoutMarginsGuide.rightAnchor, rightConstant: 0, bottom: userImage.bottomAnchor)
        }

        private func setupControls()
        {
            userImage = UIImageViewBase()
            userImage.setup
            {
                $0.backgroundColor = .black
                $0.layer.cornerRadius = 25

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
