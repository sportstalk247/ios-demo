import Foundation

public class SportsTalkSDK {
    public static let shared = SportsTalkSDK()
    public var debugMode: Bool = false
    
    private static var jwtProviders: [ClientConfig: JWTProvider] = [:]
    //
    // Method to set a JWT Provider instance for a specific config.
    //
    public static func setJWTProvider(config: ClientConfig, provider: JWTProvider) {
        jwtProviders[config] = provider
    }
    
    //
    // Method to get the JWT Provider instance for the provided config.
    //
    public static func getJWTProvider(config: ClientConfig) -> JWTProvider? {
        return jwtProviders[config]
    }
}
