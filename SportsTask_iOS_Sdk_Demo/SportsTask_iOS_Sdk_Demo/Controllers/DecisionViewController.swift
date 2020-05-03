import Foundation
import UIKit

class DecisionViewController: BaseViewController{
    
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewYAnchor: NSLayoutConstraint!
    
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    
    let portraitHeight: CGFloat = 69
    let landscapeHeight: CGFloat = 20
    var presenter: DecisionViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DecisionViewPresenter(services: services)
        chatButton.addTarget(self, action: #selector(didSelect(_:)), for: .touchUpInside)
        commentsButton.addTarget(self, action: #selector(didSelect(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func didSelect(_ sender: UIButton){
        
        let vc = UserListingViewController()
        vc.isDestinationConversation = sender == commentsButton
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (context) in
            
            if let orientation = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.windowScene?.interfaceOrientation{
                switch orientation{
                case .landscapeLeft, .landscapeRight:
                    self.titleHeight.constant = self.landscapeHeight
                    self.stackViewYAnchor.constant = self.landscapeHeight
                case .unknown:
                    break
                case .portrait, .portraitUpsideDown:
                    self.titleHeight.constant = self.portraitHeight
                    self.stackViewYAnchor.constant = 0
                @unknown default:
                    break
                }
            }
        }, completion: nil)
        
        super.viewWillTransition(to: size, with: coordinator)
    }
}
