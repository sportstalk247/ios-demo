import UIKit
import SportsTalk_iOS_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var services = Services()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        services.authToken = "vfZSpHsWrkun7Yd_fUJcWAHrNjx6VRpEqMCEP3LJV9Tg"
        services.url = URL(string: "https://api.sportstalk247.com/api/v3")
        
        return true
    }

}






















/*
 
 users and rooms are tied to an api key

 vfZSpHsWrkun7Yd_fUJcWAHrNjx6VRpEqMCEP3LJV9Tg
 vfZSpHsWrkun7Yd_fUJcWAHrNjx6VRpEqMCEP3LJV9Tg
 aldo - 001864a867604101b29672e904da688a

 sarah - 046282d5e2d249739e0080a4d2a04904

 tony - 04c0625b3a5d445d919e35b41d5883d0

 Room ID: 5dd9d5a038a28326ccfe5743
 
 */
