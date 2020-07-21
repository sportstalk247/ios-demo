import Foundation

public struct ClientConfig {
    var appId: String
    var authToken: String
    var endpoint: URL
    
    public init(appId: String, authToken: String, endpoint: URL?) {
        self.appId = appId
        self.authToken = authToken
        self.endpoint = endpoint ?? URL(string: "https://api.sportstalk247.com/api/v3")!
    }
}
