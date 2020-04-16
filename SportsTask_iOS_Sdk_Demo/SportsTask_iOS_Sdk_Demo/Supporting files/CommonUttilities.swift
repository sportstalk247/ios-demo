//
//  CommonUttilities.swift
//  SportsTask_iOS_Sdk_Demo
//
//  Created by Admin on 16/04/20.
//  Copyright © 2020 krishna41. All rights reserved.
//

import Foundation
import UIKit
class CommonUttilities: NSObject{
    
    override init() {super.init()}
    
    static let shared = CommonUttilities()
    
    var loader: MBProgressHUD?
    
    func showLoader(){
        hideLoader()
        DispatchQueue.main.async {
            if let view = self.getRootView(){
                self.loader = MBProgressHUD(view: view)
                view.addSubview(self.loader!)
                view.bringSubviewToFront(self.loader!)
                self.loader?.show(animated: true)
            }
        }
            
        
        
    }
    
    func hideLoader(){
        DispatchQueue.main.async {
            self.loader?.isHidden = true
            self.loader?.removeFromSuperview()
            self.loader = nil
        }
        
    }
    
    func getRootView() -> UIView?{
        let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
        return keyWindow?.rootViewController?.view
    }
}
