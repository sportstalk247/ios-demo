import Foundation
import UIKit

class BaseCollectionViewController: UICollectionViewController
{
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var services = appDelegate.services

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    func close()
    {
        dispatchMain
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func dispatchMain(_ callback: @escaping () -> Void)
    {
        if Thread.isMainThread
        {
            callback()
        }
        else
        {
            let queue = DispatchQueue.main
            
            queue.async
            {
                callback()
            }
        }
    }
    
    func dispatchBackground(_ callback: @escaping () -> Void)
    {
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        queue.async
        {
            callback()
        }
    }
    
    func showError(message: String)
    {
        dispatchMain
        {
            let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                
            let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel)
            {
                action -> Void in
            }
                
            alert.addAction(cancelAction)
                
            self.present(alert, animated: true, completion: nil)
        }
    }
}

