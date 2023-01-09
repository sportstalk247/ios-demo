//
//  SDKError.swift
//  SportsTalk247
//
//  Created by Angelo Lesano on 2/17/21.
//  Copyright © 2021 krishna41. All rights reserved.
//

import Foundation

public enum SDKError: Swift.Error {
    case NotAllowed
    case InvalidParameters
    case Unknown
}

extension SDKError {}

extension SDKError {
    public var localizedDescription: String {
        switch self {
        case .NotAllowed:
            return "418 - Not Allowed. Please wait to send this message again"
        case .InvalidParameters:
            return "SDK Error: Some required parameters are missing."
        case .Unknown:
            return "An unknown error has occurred."
        }
    }
}
