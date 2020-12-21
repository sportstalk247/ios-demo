//
//  UIScrollView+Extension.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 12/20/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit

extension UIScrollView {
    var scrolledToTop: Bool {
        let topEdge = 0 - contentInset.top
        return contentOffset.y <= topEdge
    }

    var scrolledToBottom: Bool {
        let bottomEdge = contentSize.height + contentInset.bottom - bounds.height
        return contentOffset.y >= bottomEdge
    }
}
