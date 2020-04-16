import Foundation

public class UsersServices
{
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
            addRequired(key: .userid, value: userid)
            
            return toDictionary
        }
        
    }
    
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
    
    
    public class ListMessagesByUser: ParametersBase<ListMessagesByUser.Fields, ListMessagesByUser>
    {
        public enum Fields
        {
            case cursor
            case limit
            case userid

        }

        public var cursor:String?
        public var limit:String? = defaultLimit
        public var userId:String?

        override public func from(dictionary: [AnyHashable: Any]) -> ListMessagesByUser
        {
            set(dictionary: dictionary)
            let ret = ListMessagesByUser()

            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            ret.userId = value(forKey: .userid)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            addRequired(key: .userid, value: userId)
            
            return toDictionary
        }
    }
    
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
