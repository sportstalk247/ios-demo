import Foundation

public protocol UserClientProtocol {
    func createOrUpdateUser(_ request: UserRequest.CreateUpdateUser, completionHandler: @escaping Completion<User>)
    func deleteUser(_ request: UserRequest.DeleteUser, completionHandler: @escaping Completion<DeleteUserResponse>)
    func getUserDetails(_ request: UserRequest.GetUserDetails, completionHandler: @escaping Completion<User>)
    func listUsers(_ request: UserRequest.ListUsers, completionHandler: @escaping Completion<ListUsersResponse>)
    func setBanStatus(_ request: UserRequest.SetBanStatus, completionHandler: @escaping Completion<User>)
    func globallyPurgeUserContent(_ request: UserRequest.GloballyPurgeUserContent, completionHandler: @escaping Completion<GlobalPurgeReponse>)
    func searchUser(_ request: UserRequest.SearchUser, completionHandler: @escaping Completion<ListUsersResponse>)
    func muteUser(_ request: UserRequest.MuteUser, completionHandler: @escaping Completion<User>)
    func reportUser(_ request: UserRequest.ReportUser, completionHandler: @escaping Completion<User>)
    func setShadowBanStatus(_ request: UserRequest.SetShadowBanStatus, completionHandler: @escaping Completion<User>)
    func listUserNotifications(_ request: UserRequest.ListUserNotifications, completionHandler: @escaping Completion<ListNotificationResponse>)
    func markAllNotificationAsRead(_ request: UserRequest.MarkAllNotificationAsRead, completionHandler: @escaping Completion<UserNotification>)
    func setUserNotificationAsRead(_ request: UserRequest.SetUserNotificationAsRead, completionHandler: @escaping Completion<UserNotification>)
    func setUserNotificationAsReadByEventId(_ request: UserRequest.SetUserNotificationAsReadByChatEventId, completionHandler: @escaping Completion<UserNotification>)
    func deleteUserNotification(_ request: UserRequest.DeleteUserNotification, completionHandler: @escaping Completion<UserNotification>)
    func deleteUserNotificationByEventId(_ request: UserRequest.DeleteUserNotificationByChatEventId, completionHandler: @escaping Completion<UserNotification>)
}

public class UserClient: NetworkService, UserClientProtocol {
    internal var lastTimeStamp: Int64 = 0
    
    public override init(config: ClientConfig) {
        super.init(config: config)
    }
}

extension UserClient {
    public func createOrUpdateUser(_ request: UserRequest.CreateUpdateUser, completionHandler: @escaping Completion<User>) {
        makeRequest(URLPath.User.CreateUpdate(userid: request.userid), withData: request.toDictionary(), requestType: .POST, expectation: User.self) { response in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func deleteUser(_ request: UserRequest.DeleteUser, completionHandler: @escaping Completion<DeleteUserResponse>) {
        makeRequest(URLPath.User.Delete(userid: request.userid), withData: request.toDictionary(), requestType: .DELETE, expectation: DeleteUserResponse.self) { response in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func getUserDetails(_ request: UserRequest.GetUserDetails, completionHandler: @escaping Completion<User>) {
        makeRequest(URLPath.User.GetDetails(userid: request.userid), withData: request.toDictionary(), requestType: .GET, expectation: User.self) { response in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }

    public func listUsers(_ request: UserRequest.ListUsers, completionHandler: @escaping Completion<ListUsersResponse>) {
        makeRequest(URLPath.User.List(), withData: request.toDictionary(), requestType: .GET, expectation: ListUsersResponse.self, append: true) { response in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func setBanStatus(_ request: UserRequest.SetBanStatus, completionHandler: @escaping Completion<User>) {
        makeRequest(URLPath.User.Ban(userid: request.userid), withData: request.toDictionary(), requestType: .POST, expectation: User.self) { response in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func globallyPurgeUserContent(_ request: UserRequest.GloballyPurgeUserContent, completionHandler: @escaping Completion<GlobalPurgeReponse>) {
        makeRequest(URLPath.User.GlobalPurge(userid: request.userid), withData: request.toDictionary(), requestType: .POST, expectation: GlobalPurgeReponse.self) { response in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func searchUser(_ request: UserRequest.SearchUser, completionHandler: @escaping Completion<ListUsersResponse>) {
        makeRequest(URLPath.User.Search(), withData: request.toDictionary(), requestType: .POST, expectation: ListUsersResponse.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func muteUser(_ request: UserRequest.MuteUser, completionHandler: @escaping Completion<User>) {
        makeRequest(URLPath.User.Mute(userid: request.userid), withData: request.toDictionary(), requestType: .POST, expectation: User.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func reportUser(_ request: UserRequest.ReportUser, completionHandler: @escaping Completion<User>) {
        makeRequest(URLPath.User.Report(userid: request.userid), withData: request.toDictionary(), requestType: .POST, expectation: User.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func setShadowBanStatus(_ request: UserRequest.SetShadowBanStatus, completionHandler: @escaping Completion<User>) {
        makeRequest(URLPath.User.ShadowBan(userid: request.userid), withData: request.toDictionary(), requestType: .POST, expectation: User.self) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listUserNotifications(_ request: UserRequest.ListUserNotifications, completionHandler: @escaping Completion<ListNotificationResponse>) {
        makeRequest(URLPath.User.ListNotifications(userid: request.userid), withData: request.toDictionary(), requestType: .GET, expectation: ListNotificationResponse.self, append: true) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func markAllNotificationAsRead(_ request: UserRequest.MarkAllNotificationAsRead, completionHandler: @escaping Completion<UserNotification>) {
        makeRequest(URLPath.User.MarkAllNotifAsRead(userid: request.userid), withData: request.toDictionary(), requestType: .PUT, expectation: UserNotification.self, append: true) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func setUserNotificationAsRead(_ request: UserRequest.SetUserNotificationAsRead, completionHandler: @escaping Completion<UserNotification>) {
        makeRequest(URLPath.User.SetNotifRead(userid: request.userid, noteid: request.notificationid), withData: request.toDictionary(), requestType: .PUT, expectation: UserNotification.self, append: true) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func setUserNotificationAsReadByEventId(_ request: UserRequest.SetUserNotificationAsReadByChatEventId, completionHandler: @escaping Completion<UserNotification>) {
        makeRequest(URLPath.User.SetNotifRead(userid: request.userid, eventid: request.eventid), withData: request.toDictionary(), requestType: .PUT, expectation: UserNotification.self, append: true) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func deleteUserNotification(_ request: UserRequest.DeleteUserNotification, completionHandler: @escaping Completion<UserNotification>) {
        makeRequest(URLPath.User.DeleteNotif(userid: request.userid, noteid: request.notificationid), withData: request.toDictionary(), requestType: .DELETE, expectation: UserNotification.self, append: true) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func deleteUserNotificationByEventId(_ request: UserRequest.DeleteUserNotificationByChatEventId, completionHandler: @escaping Completion<UserNotification>) {
        makeRequest(URLPath.User.DeleteNotif(userid: request.userid, eventid: request.eventid), withData: request.toDictionary(), requestType: .DELETE, expectation: UserNotification.self, append: true) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
}
