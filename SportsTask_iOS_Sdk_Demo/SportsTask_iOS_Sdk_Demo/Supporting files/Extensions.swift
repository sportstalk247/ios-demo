//
//  Extensions.swift
//  SportsTask_iOS_Sdk_Demo
//
//  Created by Admin on 15/04/20.
//  Copyright © 2020 krishna41. All rights reserved.
//

import Foundation
import UIKit
protocol BaseProtocol {
    func startLoader()
    func stopLoader()
}
extension NSObject{
    
    func showMessage(message: String, positiveButtonText: String = "Ok",negativeButtonText: String? = nil ,completion: @escaping (Bool) -> Void){
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
        DispatchQueue.main.async {
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
