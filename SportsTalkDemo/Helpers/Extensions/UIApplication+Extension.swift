//
//  UIApplication+Extension.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/10/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit

extension UIApplication {
    class func rootViewController() -> UIViewController? {
        return self.shared.windows.first?.rootViewController
    }

    
    class func topMostViewController(base: UIViewController? = UIApplication.rootViewController()) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topMostViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topMostViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topMostViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }
        
        return base
    }

}
