import Foundation

public struct ClientConfig: Hashable {
    var appId: String
    var authToken: String
    var endpoint: URL
    
    public init(appId: String, authToken: String, endpoint: URL) {
        self.appId = appId
        self.authToken = authToken
        self.endpoint = endpoint
    }
}
