import UIKit
import SportsTalk_iOS_SDK

protocol UserListingView
{
    func refresh()
//    func startLoader()
//    func stopLoader()
}

class UserListingViewPresenter
{
    private var view: UserListingView!
    private var services: Services!
    
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
            CommonUttilities.shared.hideLoader()
            
            return
        }
        
        let request = UsersServices.GetUserDetails()
        request.userid = userIds[index]
        
        CommonUttilities.shared.showLoader()
        
        services.ams.usersServices(request) { (response) in
            if let response = response["data"] as? [String: Any]
            {
                self.users.append(User().convertIntoModel(response: response))
            }
            
            self.loadUser(index: index + 1)
        }
    }
}

