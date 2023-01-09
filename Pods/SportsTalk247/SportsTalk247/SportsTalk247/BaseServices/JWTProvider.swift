//
//  JWTProvider.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 12/14/22.
//  Copyright © 2022 krishna41. All rights reserved.
//

import Foundation

public typealias TokenRefreshCompletionHandler = ((String) -> Void)
public typealias TokenRefreshAction = ((@escaping TokenRefreshCompletionHandler) -> Void)

public class JWTProvider {
    
    private var token: String? = nil
    private var tokenRefreshFunction: TokenRefreshAction? = nil
    
    public init(token: String? = nil, tokenRefreshFunction: TokenRefreshAction? = nil) {
        self.token = token
        self.tokenRefreshFunction = tokenRefreshFunction
    }
    
    public func getToken() -> String? {
        return token
    }
    
    public func setToken(_ value: String?) {
        self.token = value
    }
    
    public func refreshToken() {
        tokenRefreshFunction? { [weak self] newToken in
            guard let self else { return }
            self.token = newToken
        }
    }
    
}
