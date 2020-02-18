import UIKit
import SportsTalk_iOS_SDK

protocol UserListingView
{
    func refresh()
}

class UserListingViewPresenter
{
    private var view: UserListingView!
    private var services: Services!
    
    let userIds = ["001864a867604101b29672e904da688a", "046282d5e2d249739e0080a4d2a04904", "04c0625b3a5d445d919e35b41d5883d0"]
    var users = [User]()
    
    init(view: UserListingView, services: Services)
    {
        self.view = view
        self.services = services
    }

    func loadUsersDetail()
    {
        loadUser(index: 0)
    }
    
    func loadUser(index: Int)
    {
        if index == userIds.count
        {
            view.refresh()
            
            return
        }
        
        let request = UsersServices.GetUserDetails()
        request.userid = userIds[index]
        
        services.ams.usersServices(request) { (response) in
            var user = User()
            
            if let response = response["data"] as? [String: Any]
            {
                user = user.convertIntoModel(response: response)
                self.users.append(user)
            }
            
            self.loadUser(index: index + 1)
        }
    }
}

