import Foundation
import UIKit

class CommentConversationsViewController: BaseViewController{
    private var presenter: CommentConversationsViewPresenter!
    var adapter: CommentConversationsAdapter?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        setup()
    }
    func setup(){
        presenter = CommentConversationsViewPresenter(services: services, view: self)
        addViews()
    }
    
    func addViews(){
        [collectionView].forEach{view.addSubview($0)}
        setupConstraints()
    }
    
    func setupConstraints(){
       let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.alwaysBounceVertical = true
        v.register(CommentConversationCell.self, forCellWithReuseIdentifier: "CommentConversationCell")
        v.refreshControl = self.refreshControl
        return v
    }()
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        presenter.loadData()
        refreshControl.endRefreshing()
    }
}
extension CommentConversationsViewController: CommentConversationsView{
    func goToCommentsScreen() {
        dispatchMain {
            let vc = CommentsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showData() {
        dispatchMain {
            self.adapter = nil
            self.adapter = CommentConversationsAdapter(presenter: self.presenter)
            self.collectionView.delegate = self.adapter
            self.collectionView.dataSource = self.adapter
        }
        
    }
}
extension CommentConversationsViewController{
    class CommentConversationsAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
        
        let presenter: CommentConversationsViewPresenter!
        
        init(presenter: CommentConversationsViewPresenter) {
            self.presenter = presenter
            super.init()
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            presenter.didSelectConversation(index: indexPath.item)
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            presenter?.array.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentConversationCell", for: indexPath) as! CommentConversationCell
            cell.model = presenter?.array[indexPath.item]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: collectionView.frame.width, height: 50)
        }
    }
}
