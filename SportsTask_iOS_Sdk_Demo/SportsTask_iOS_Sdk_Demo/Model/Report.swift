//
//  Report.swift
//  SportsTask_iOS_Sdk_Demo
//
//  Created by Admin on 15/04/20.
//  Copyright © 2020 krishna41. All rights reserved.
//

import Foundation
struct Report{
    let userid: String
    let reason: String
    
    static func from(dict: [String:Any]) -> Report{
        let userid = dict["userid"] as? String ?? ""
        let reason = dict["reason"] as? String ?? ""
        return Report(userid: userid, reason: reason)
    }
}
