//
//  Date+Extension.swift
//  SportsTalkDemo
//
//  Created by Angelo Lesano on 5/30/20.
//  Copyright © 2020 com.sportstalk.SDK. All rights reserved.
//

import Foundation

extension Date {
    func deriveAge() -> Int {
        let now = Date()
        let birthday: Date = self
        let calendar = Calendar.current

        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        return ageComponents.year!
    }
}
