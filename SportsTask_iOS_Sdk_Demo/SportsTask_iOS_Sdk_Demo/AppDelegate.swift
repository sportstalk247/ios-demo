import UIKit
import SportsTalk_iOS_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var services = Services()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        services.authToken = "vfZSpHsWrkun7Yd_fUJcWAHrNjx6VRpEqMCEP3LJV9Tg"
        services.url = URL(string: "http://shaped-entropy-259212.appspot.com/demo/api/v3")
        //"https://api.sportstalk247.com/api/v3")
        
        return true
    }

}





