import UIKit
import SportsTalk_iOS_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var services = Services()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        services.appId = "5e92a5ce38a28d0b6453687a"
        services.authToken = "QZF6YKDKSUCeL03tdA2l2gx4ckSvC7LkGsgmix-pBZLA"
        services.url = URL(string: "https://api.sportstalk247.com/api/v3")
        return true
    }
}

/*
 Please check the Constants.swift file for user ids, room id, and comment user id being used in this demo.
 */
