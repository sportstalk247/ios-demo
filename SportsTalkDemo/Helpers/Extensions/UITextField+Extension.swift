//
//  UITextField+Extension.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 6/5/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .filter { $0 == self }
            .map { $0.text }
            .eraseToAnyPublisher()
    }
}
