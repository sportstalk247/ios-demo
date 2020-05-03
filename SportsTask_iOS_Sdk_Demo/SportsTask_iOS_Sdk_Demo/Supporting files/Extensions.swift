import Foundation
import UIKit

extension CGSize {
    func bma_round() -> CGSize {
        return CGSize(width: self.width.bma_round(), height: self.height.bma_round())
    }
}

extension CGFloat {
    func bma_round() -> CGFloat {
        let scale = UIScreen.main.scale
        return ceil(self * scale) * (1.0 / scale)
    }
}

extension CGSize {
    func bma_equal(other: CGSize) -> Bool {
        return abs(self.width - other.width) < 0.001 && abs(self.height - other.height) < 0.001

    }
}

extension String{
    var trim: String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIDevice{
    var hasTopNotch: Bool{
        
        if let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}){
            var val: CGFloat = 0
            let insets = window.safeAreaInsets
            switch window.windowScene?.interfaceOrientation {
            case .landscapeRight:
                val = insets.right
            case .landscapeLeft:
                val = insets.left
            case .portrait:
                val = insets.top
            case .portraitUpsideDown:
                val = insets.top
            default:
                val = 0
            }
            return val > 24
        }
        return false
    }
}

extension NSObject{
    
    func showMessage(message: String, positiveButtonText: String = "Ok",negativeButtonText: String? = nil ,completion: @escaping (Bool) -> Void){
         DispatchQueue.main.async {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: positiveButtonText, style: .default, handler: { action in
              switch action.style{
              case .default:
                    completion(true)
              default:
                print("handle another case")
                completion(false)
            }}))
        if (negativeButtonText != nil){
            alert.addAction(UIAlertAction(title: negativeButtonText, style: .cancel, handler: { action in
                completion(false)
            }))
        }
       
            let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
            keyWindow?.rootViewController?.present(alert, animated: true)
        }
        
    }
    
    public func alertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil, completion: @escaping ((String) -> Void) = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in completion("") })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            { completion(result) }
            else
            { completion("") }
        })
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
            keyWindow?.rootViewController?.present(alert, animated: true)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        print("dismiss keyboard called")
        view.endEditing(true)
    }
}
