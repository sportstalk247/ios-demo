import Foundation

public class UsersServices
{
    
    /// Invoke this API method if you want to create a user or update an existing user.
    ///
    /// When users send messages to a room the user ID is passed as a parameter. When you retrieve the events from a room, the user who generated the event is returned with the event data, so it is easy for your application to process and render chat events with minimal code.
    ///
    /// userid: Required. If the userid is new then the user will be created. If the userid is already in use in the database then the user will be updated.
    ///
    /// handle: (Optional) If you are creating a user and you don't specify a handle, the system will generate one for you (using Display Name as basis if you provide that). If you request a handle and it's already in use a new handle will be generated for you and returned. Handle is an easy to type unique identifier for a user, for example @GeorgeWashington could be the handle but Display Name could be "da prez numero uno".
    ///
    /// displayname: Optional. This is the desired name to display, typically the real name of the person.
    ///
    /// pictureurl: Optional. The URL to the picture for this user.
    ///
    /// profileurl: Optional. The profileurl for this user.
    ///
    /// - Warning: Do not use this method to convert an anonymous user into a known user. Use the Convert User api method instead.
    public class CreateUpdateUser: ParametersBase<CreateUpdateUser.Fields, CreateUpdateUser>
    {
        public enum Fields
        {
            case userid
            case handle
            case displayname
            case pictureurl
            case profileurl
        }

        public var userid: String?
        public var handle: String?
        public var displayname: String?
        public var pictureurl: URL?
        public var profileurl: URL?

        override public func from(dictionary: [AnyHashable: Any]) -> CreateUpdateUser
        {
            set(dictionary: dictionary)
            let ret = CreateUpdateUser()

            ret.userid = value(forKey: .userid)
            ret.handle = value(forKey: .handle)
            ret.displayname = value(forKey: .displayname)
            ret.pictureurl = value(forKey: .pictureurl)
            ret.profileurl = value(forKey: .profileurl)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .userid, value: userid)
            add(key: .handle, value: handle)
            add(key: .displayname, value: displayname)
            add(key: .pictureurl, value: pictureurl?.absoluteString)
            add(key: .profileurl, value: profileurl?.absoluteString)

            return toDictionary
        }
    }
    
    /// Deletes the specified user.
    ///
    /// All rooms with messages by that user will have the messages from this user purged in the rooms.
    ///
    /// UserId is the app specific User ID provided by your application.
    ///
    /// - Warning: This method requires authentication
    public class DeleteUser: ParametersBase<DeleteUser.Fields,DeleteUser>
    {
        public enum Fields
        {
            case userid
        }
        public var userid: String?
        
        override func from(dictionary: [AnyHashable : Any]) -> UsersServices.DeleteUser
        {
            set(dictionary: dictionary)
            let ret = DeleteUser()
            
            ret.userid = value(forKey: .userid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable : Any]
        {
            toDictionary = [AnyHashable: Any]()
            add(key: .userid, value: userid)
            addRequired(key: .userid, value: userid)
            
            return toDictionary
        }
        
    }
    
    /// Get the details about a User
    ///
    /// This will return all the information about the user.
    ///
    /// UserId is the app specific User ID provided by your application.
    ///
    /// - Warning: This method requires authentication
    public class GetUserDetails: ParametersBase<GetUserDetails.Fields, GetUserDetails>
    {
        public enum Fields
        {
            case userid
        }
        
        public var userid: String?

        override public func from(dictionary: [AnyHashable: Any]) -> GetUserDetails
        {
            set(dictionary: dictionary)
            let ret = GetUserDetails()
            ret.userid = value(forKey: .userid)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .userid, value: userid)

            return toDictionary
        }
    }
    
    /// Use this method to cursor through a list of users. This method will return users in the order in which they were created, so it is safe to add new users while cursoring through the list.
    ///
    /// cursor: Each call to ListUsers will return a result set with a 'nextCursor' value. To get the next page of users, pass this value as the optional 'cursor' property. To get the first page of users, omit the 'cursor' argument.
    ///
    /// limit: You can omit this optional argument, in which case the default limit is 200 users to return.
    ///
    /// - Warning: This method requires authentication.
    public class ListUsers: ParametersBase<ListUsers.Fields, ListUsers>
    {
        public enum Fields
        {
            case cursor
            case limit
        }

        public var cursor: String?
        public var limit: String? = defaultLimit

        override public func from(dictionary: [AnyHashable: Any]) -> ListUsers
        {
            set(dictionary: dictionary)
            let ret = ListUsers()

            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }

    /// Use this method to cursor through a list of users. This method will return users in the order in which they were created, so it is safe to add new users while cursoring through the list.
    ///
    /// cursor: Each call to ListUsers will return a result set with a 'nextCursor' value. To get the next page of users, pass this value as the optional 'cursor' property. To get the first page of users, omit the 'cursor' argument.
    ///
    /// limit: You can omit this optional argument, in which case the default limit is 200 users to return.
    ///
    /// - Warning: This method requires authentication.
    public class ListUsersMore: ParametersBase<ListUsersMore.Fields, ListUsersMore>
    {
        public enum Fields
        {
            case cursor
            case limit
        }

        public var cursor: String?
        public var limit: String? = defaultLimit

        override public func from(dictionary: [AnyHashable: Any]) -> ListUsersMore
        {
            set(dictionary: dictionary)
            let ret = ListUsersMore()

            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }
    
    /// Use this method ban a user.
    ///
    /// userid: (required) The applicaiton provided userid of the user to ban
    ///
    /// - Warning: This method requires authentication.
    public class BanUser: ParametersBase<BanUser.Fields, BanUser>
    {
        public enum Fields
        {
            case userid
            case banned
        }

        public var userid: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> BanUser
        {
            set(dictionary: dictionary)
            let ret = BanUser()

            ret.userid = value(forKey: .userid)
         
            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .userid, value: userid)
            add(key: .banned, value: true)
            
            addRequired(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// Use this method restore a user.
    ///
    /// userid: (required) The applicaiton provided userid of the user to restore
    ///
    /// - Warning: This method requires authentication.
    public class RestoreUser: ParametersBase<RestoreUser.Fields, RestoreUser>
    {
        public enum Fields
        {
            case userid
            case banned
        }

        public var userid: String?
    
        override public func from(dictionary: [AnyHashable: Any]) -> RestoreUser
        {
            set(dictionary: dictionary)
            let ret = RestoreUser()

            ret.userid = value(forKey: .userid)
         
            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .userid, value: userid)
            add(key: .banned, value: false)
            
            addRequired(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// Searches the users in an app
    ///
    /// Use this method to cursor through a list of users. This method will return users in the order in which they were created, so it is safe to add new users while cursoring through the list.
    ///
    /// userid: Required. If the userid is new then the user will be created. If the userid is already in use in the database then the user will be updated.
    ///
    /// Arguments:
    ///
    /// cursor: Each call to ListUsers will return a result set with a 'nextCursor' value. To get the next page of users, pass this value as the optional 'cursor' property. To get the first page of users, omit the 'cursor' argument.
    ///
    /// limit: You can omit this optional argument, in which case the default limit is 200 users to return.
    ///
    /// name: Provide part of a name to search the user name field
    ///
    /// handle: Provide part of a handle to search by handle
    ///
    /// userid: Provide part of a userid to search by userid
    ///
    /// - Warning: This method requires authentication.
    public class SearchUsersByHandle: ParametersBase<SearchUsersByHandle.Fields, SearchUsersByHandle>
    {
        public enum Fields
        {
            case cursor
            case limit
            case name
            case handle
            case userid
        }

        public var cursor:String?
        public var limit:String?
        public var name:String?
        public var handle:String?
        public var userid:String?

        override public func from(dictionary: [AnyHashable: Any]) -> SearchUsersByHandle
        {
            set(dictionary: dictionary)
            let ret = SearchUsersByHandle()

            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            ret.name = value(forKey: .name)
            ret.handle = value(forKey: .handle)
            ret.userid = value(forKey: .userid)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            add(key: .name, value: name)
            add(key: .userid, value: userid)
            addRequired(key: .handle, value: handle)
            return toDictionary
        }
    }
    
    /// Searches the users in an app
    ///
    /// Use this method to cursor through a list of users. This method will return users in the order in which they were created, so it is safe to add new users while cursoring through the list.
    ///
    /// userid: Required. If the userid is new then the user will be created. If the userid is already in use in the database then the user will be updated.
    ///
    /// Arguments:
    ///
    /// cursor: Each call to ListUsers will return a result set with a 'nextCursor' value. To get the next page of users, pass this value as the optional 'cursor' property. To get the first page of users, omit the 'cursor' argument.
    ///
    /// limit: You can omit this optional argument, in which case the default limit is 200 users to return.
    ///
    /// name: Provide part of a name to search the user name field
    ///
    /// handle: Provide part of a handle to search by handle
    ///
    /// userid: Provide part of a userid to search by userid
    ///
    /// - Warning: This method requires authentication.
    public class SearchUsersByName: ParametersBase<SearchUsersByName.Fields, SearchUsersByName>
    {
        public enum Fields
        {
            case cursor
            case limit
            case name
            case handle
            case userid

        }

        public var cursor:String?
        public var limit:String?
        public var name:String?
        public var handle:String?
        public var userId:String?

        override public func from(dictionary: [AnyHashable: Any]) -> SearchUsersByName
        {
            set(dictionary: dictionary)
            let ret = SearchUsersByName()

            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            ret.name = value(forKey: .name)
            ret.handle = value(forKey: .handle)
            ret.userId = value(forKey: .userid)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            addRequired(key: .name, value: name)
            add(key: .handle, value: handle)
            add(key: .userid, value: userId)
            
            return toDictionary
        }
    }
    
    /// Searches the users in an app
    ///
    /// Use this method to cursor through a list of users. This method will return users in the order in which they were created, so it is safe to add new users while cursoring through the list.
    ///
    /// userid: Required. If the userid is new then the user will be created. If the userid is already in use in the database then the user will be updated.
    ///
    /// Arguments:
    ///
    /// cursor: Each call to ListUsers will return a result set with a 'nextCursor' value. To get the next page of users, pass this value as the optional 'cursor' property. To get the first page of users, omit the 'cursor' argument.
    ///
    /// limit: You can omit this optional argument, in which case the default limit is 200 users to return.
    ///
    /// name: Provide part of a name to search the user name field
    ///
    /// handle: Provide part of a handle to search by handle
    ///
    /// userid: Provide part of a userid to search by userid
    ///
    /// - Warning: This method requires authentication.
    public class SearchUsersByUserId: ParametersBase<SearchUsersByUserId.Fields, SearchUsersByUserId>
    {
        public enum Fields
        {
            case cursor
            case limit
            case name
            case handle
            case userid

        }

        public var cursor:String?
        public var limit:String?
        public var name:String?
        public var handle:String?
        public var userId:String?

        override public func from(dictionary: [AnyHashable: Any]) -> SearchUsersByUserId
        {
            set(dictionary: dictionary)
            let ret = SearchUsersByUserId()

            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            ret.name = value(forKey: .name)
            ret.handle = value(forKey: .handle)
            ret.userId = value(forKey: .userid)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            add(key: .name, value: name)
            add(key: .handle, value: handle)
            addRequired(key: .userid, value: userId)
            
            return toDictionary
        }
    }
}
