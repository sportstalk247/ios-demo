import Foundation

public class ChatRequest {
    /// Creates a new chat room
    ///
    /// **Parameters**
    ///
    /// - name: (required) The name of the room
    ///
    /// - customid: (optional) A customid for the room. Can be unused, or a unique key.
    ///
    /// - description: (optional) The description of the room
    ///
    /// - moderation: (required) The type of moderation.
    ///     - `pre` - marks the room as Premoderated
    ///     - `post` - marks the room as Postmoderated
    ///
    /// - enableactions: (optional) [true/false] Turns action commands on or off
    ///
    /// - enableenterandexit: (optional) [true/false] Turn enter and exit events on or off. Disable for large rooms to reduce noise.
    ///
    /// - enableprofanityfilter: (optional) [default=true / false] Enables profanity filtering.
    ///
    /// - enableautoexpiresessions: (optional) [defaulttrue / false] Enables automatically expiring idle sessions, which removes inactive users from the room
    ///
    /// - delaymessageseconds: (optional) [default=0] Puts a delay on messages from when they are submitted until they show up in the chat. Used for throttling.
    ///
    /// - maxreports: (optiona) Default is 3. This is the maximum amount of user reported flags that can be applied to a message before it is sent to the moderation queue
    ///
    /// **Warning** This method requires authentication
    ///
    public class CreateRoom: ParametersBase<CreateRoom.Fields, CreateRoom> {
        public enum Fields {
            case name
            case customid
            case description
            case moderation
            case enableactions
            case enableenterandexit
            case enableprofanityfilter
            case roomisopen
            case maxreports
            
            case pictureurl
            case enableautoexpiresessions
            case delaymessageseconds
            case customtype
            case custompayload
            case customfield1
            case customfield2
            case customtags
            case `private`
        }
        
        public var name: String?
        public var customid: String?
        public var description: String?
        public var moderation: String?
        public var enableactions: Bool?
        public var enableenterandexit: Bool?
        public var enableprofanityfilter: Bool?
        public var enableautoexpiresessions: Bool?
        public var roomisopen: Bool?
        public var maxreports: Int? = 3
        
        public var pictureurl: String?
        public var delaymessageseconds: Int64?
        public var customtype: String?
        public var custompayload: String?
        public var customfield1: String?
        public var customfield2: String?
        public var customtags: [String]?  // A comma delimited list of tags
        public var `private`: Bool?
        
        public init(name: String? = nil, customid: String? = nil, description: String? = nil, moderation: String? = nil, enableactions: Bool? = nil, enableenterandexit: Bool? = nil, enableprofanityfilter: Bool? = nil, enableautoexpiresessions: Bool? = nil, roomisopen: Bool? = nil, maxreports: Int? = nil, pictureurl: String? = nil, delaymessageseconds: Int64? = nil, customtype: String? = nil, custompayload: String? = nil, customfield1: String? = nil, customfield2: String? = nil, customtags: [String]? = nil) {
            self.name = name
            self.customid = customid
            self.description = description
            self.moderation = moderation
            self.enableactions = enableactions
            self.enableenterandexit = enableenterandexit
            self.enableprofanityfilter = enableprofanityfilter
            self.enableautoexpiresessions = enableautoexpiresessions
            self.roomisopen = roomisopen
            self.maxreports = maxreports
            self.pictureurl = pictureurl
            self.delaymessageseconds = delaymessageseconds
            self.customtype = customtype
            self.custompayload = custompayload
            self.customfield1 = customfield1
            self.customfield2 = customfield2
            self.customtags = customtags
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> CreateRoom {
            set(dictionary: dictionary)
            let ret = CreateRoom()
        
            ret.name = value(forKey: .name)
            ret.customid = value(forKey: .customid)
            ret.description = value(forKey: .description)
            ret.enableactions = value(forKey: .enableactions)
            ret.enableenterandexit = value(forKey: .enableenterandexit)
            ret.enableprofanityfilter = value(forKey: .enableprofanityfilter)
            ret.enableautoexpiresessions = value(forKey: .enableautoexpiresessions)
            ret.roomisopen = value(forKey: .roomisopen)
            ret.maxreports = value(forKey: .maxreports)
            
            ret.pictureurl = value(forKey: .pictureurl)
            ret.delaymessageseconds = value(forKey: .delaymessageseconds)
            ret.customtype = value(forKey: .customtype)
            ret.custompayload = value(forKey: .custompayload)
            ret.customfield1 = value(forKey: .customfield1)
            ret.customfield2 = value(forKey: .customfield2)
            ret.customtags = value(forKey: .customtags)
            ret.`private` = value(forKey: .private)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .name, value: name)
            
            add(key: .name, value: name)
            add(key: .customid, value: customid)
            add(key: .description, value: description)
            add(key: .moderation, value: moderation)
            add(key: .enableactions, value: enableactions)
            add(key: .enableenterandexit, value: enableenterandexit)
            add(key: .enableprofanityfilter, value: enableprofanityfilter)
            add(key: .enableautoexpiresessions, value: enableautoexpiresessions)
            add(key: .roomisopen, value: roomisopen)
            add(key: .maxreports, value: maxreports)
            
            add(key: .pictureurl, value: pictureurl)
            add(key: .delaymessageseconds, value: delaymessageseconds)
            add(key: .customtype, value: customtype)
            add(key: .custompayload, value: custompayload)
            add(key: .customfield1, value: customfield1)
            add(key: .customfield2, value: customfield2)
            add(key: .customtags, value: customtags)
            add(key: .private, value: `private`)
            
            return toDictionary
        }
    }
    
    /// Get the details for a room
    ///
    /// This will return all the settings for the room and the participant count but not the participant list
    ///
    /// **Parameters**
    /// 
    /// - roomid: (required) Room id of a specific room againts which you want to fetch the details
    ///
    /// **Warning** This method requires authentication
    ///
    public class GetRoomDetails: ParametersBase<GetRoomDetails.Fields, GetRoomDetails> {
        public enum Fields {
            case roomid
        }
        
        public let roomid: String   // REQUIRED
        
        public init(roomid: String) {
            self.roomid = roomid
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetRoomDetails {
            set(dictionary: dictionary)
            let ret = GetRoomDetails(
                roomid: value(forKey: .roomid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            
            return toDictionary
        }
    }
    
    /// Get the details for a room
    ///
    /// This method lets you specify a list of entity types to return. You can use it to get room details as well as statistics and other data associated with a room that is not part of the room entity.
    ///
    /// You must specify one or more roomid values or customid values. You may optionally provide both roomid and customid values. You may not request more than 20 rooms at once total. You must specify at least one entity type.
    ///
    /// In the future, each entity requested will count towards your API usage quota, so don't request data you will not be using.
    ///
    /// The response will be a list of RoomExtendedDetails objects. They contain properties such as room, mostrecentmessagetime, and inroom. These properties will be null if their entity type is not specified
    ///
    /// **Parameters**
    ///
    /// - roomid: (optional) A list of room IDs
    ///
    /// - customid: (optional) A list of room customIDs.
    ///
    /// - entity: (required) Specify one or more ENTITY TYPES to include in the response. Use one or more of the types below.
    ///
    ///     - room: This returns the room entity.
    ///
    ///     - numparticipants: This returns number of active participants / room subscribers.
    ///
    ///     - lastmessagetime: This returns the time stamp for the most recent event that is a visible displayable message (speech, quote, threaded reply or announcement).
    ///
    /// **Warning** This method requires authentication
    ///
    public class GetRoomExtendedDetails: ParametersBase<GetRoomExtendedDetails.Fields, GetRoomExtendedDetails> {
        public enum Fields {
            case roomid
            case customid
            case entity
        }
        
        public let roomid: [String]
        public let customid: [String]
        public let entity: [RoomEntityType]
        
        public init(roomid: [String] = [], customid: [String] = [], entity: [RoomEntityType]) {
            self.roomid = roomid
            self.customid = customid
            self.entity = entity
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetRoomExtendedDetails {
            set(dictionary: dictionary)
            let ret = GetRoomExtendedDetails(
                roomid: value(forKey: .roomid) ?? [],
                customid: value(forKey: .customid) ?? [],
                entity: value(forKey: .entity) ?? []
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            let uniqueEntity = Array<RoomEntityType>.uniqueElementsFrom(array: entity)
            addRequired(key: .entity, value: uniqueEntity.map{ $0.rawValue })
            let uniqueRoomIds = Array<String>.uniqueElementsFrom(array: roomid)
            add(key: .roomid, value: uniqueRoomIds)
            let uniqueCustomIds = Array<String>.uniqueElementsFrom(array: customid)
            add(key: .customid, value: uniqueCustomIds)
            
            return toDictionary
        }
    }
    
    /// Get the details for a room
    ///
    /// This will return all the settings for the room and the participant count but not the participant list.
    ///
    /// **Parameters**
    ///
    /// - customid: Custom Id of a specific room againts which you want to fetch the details.
    ///
    /// **Warning** This method requires authentication
    ///
    public class GetRoomDetailsByCustomId: ParametersBase<GetRoomDetailsByCustomId.Fields, GetRoomDetailsByCustomId> {
        public enum Fields {
            case customid
        }
        
        public let customid: String // REQUIRED
        
        public init(customid: String) {
            self.customid = customid
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetRoomDetailsByCustomId {
            set(dictionary: dictionary)
            let ret = GetRoomDetailsByCustomId(
                customid: value(forKey: .customid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .customid, value: customid)
            
            return toDictionary
        }
    }
    
    
    /// Permanently deletes a chat room
    ///
    /// This cannot be reversed. This command permanently deletes the chat room and all events in it.
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) that you want to delete
    ///
    /// **Warning** This method requires authentication
    ///
    public class DeleteRoom: ParametersBase<DeleteRoom.Fields, DeleteRoom> {
        public enum Fields {
            case roomid
        }
        
        public let roomid: String   // REQUIRED
        
        public init(roomid: String) {
            self.roomid = roomid
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> DeleteRoom {
            set(dictionary: dictionary)
            let ret = DeleteRoom(
                roomid: value(forKey: .roomid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            return toDictionary
        }
    }
    
    /// Updates an existing room
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) The ID of the existing room.
    ///
    /// - userid: (optional) The owner of the room.
    ///
    /// - name: (optional) The name of the room.
    ///
    /// - description: (optional) The description of the room.
    ///
    /// - moderation: (optional) [premoderation/postmoderation] Defaults to post-moderation.
    ///
    /// - enableactions: (optional) [true/false] Turns action commands on or off.
    ///
    /// - enableenterandexit: (optional) [true/false] Turn enter and exit events on or off. Disable for large rooms to reduce noise.
    ///
    /// - enableprofanityfilter: (optional) [default=true / false] Enables profanity filtering.
    ///
    /// - enableautoexpiresessions: (optional) [defaulttrue / false] Enables automatically expiring idle sessions, which removes inactive users from the room
    ///
    /// - delaymessageseconds: (optional) [default=0] Puts a delay on messages from when they are submitted until they show up in the chat. Used for throttling
    ///
    /// - roomisopen: (optional) [true/false] If false, users cannot perform any commands in the room, chat is suspended.
    ///
    /// - throttle: (optional) [default=0] This is the number of seconds to delay new incomming messags so that the chat room doesn't scroll messages too fast
    ///
    /// **Warning** This method requires authentication
    ///
    public class UpdateRoom: ParametersBase<UpdateRoom.Fields, UpdateRoom> {
        public enum Fields {
            case roomid
            case name
            case description
            case customid
            case moderation
            case enableactions
            case enableenterandexit
            case enableprofanityfilter
            case enableautoexpiresessions
            case delaymessageseconds
            case roomisopen
            case throttle
            case userid
        }
        
        public let roomid: String   // REQUIRED
        public var name: String?
        public var description: String?
        public var customid: String?
        public var moderation: String?
        public var enableactions: Bool?
        public var enableenterandexit: Bool?
        public var enableprofanityfilter: Bool?
        public var enableautoexpiresessions: Bool?
        public var delaymessageseconds: Int?
        public var roomisopen: Bool?
        public var throttle: Int?
        public var userid: String?
        
        public init(roomid: String, name: String? = nil, description: String? = nil, customid: String? = nil, moderation: String? = nil, enableactions: Bool? = nil, enableenterandexit: Bool? = nil, enableprofanityfilter: Bool? = nil, enableautoexpiresessions: Bool? = nil, delaymessageseconds: Int? = nil, roomisopen: Bool? = nil, throttle: Int? = nil, userid: String? = nil) {
            self.roomid = roomid
            self.name = name
            self.description = description
            self.customid = customid
            self.moderation = moderation
            self.enableactions = enableactions
            self.enableenterandexit = enableenterandexit
            self.enableprofanityfilter = enableprofanityfilter
            self.enableautoexpiresessions = enableautoexpiresessions
            self.delaymessageseconds = delaymessageseconds
            self.roomisopen = roomisopen
            self.throttle = throttle
            self.userid = userid
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> UpdateRoom {
            set(dictionary: dictionary)
            let ret = UpdateRoom(
                roomid: value(forKey: .roomid) ?? "",
                name: value(forKey: .name),
                description: value(forKey: .description),
                customid: value(forKey: .customid),
                moderation: value(forKey: .moderation),
                enableactions: value(forKey: .enableactions),
                enableenterandexit: value(forKey: .enableenterandexit),
                enableprofanityfilter: value(forKey: .enableprofanityfilter),
                enableautoexpiresessions: value(forKey: .enableautoexpiresessions),
                delaymessageseconds: value(forKey: .delaymessageseconds),
                roomisopen: value(forKey: .roomisopen),
                throttle: value(forKey: .throttle),
                userid: value(forKey: .userid)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .roomid, value: roomid)
            add(key: .name, value: name)
            add(key: .description, value: description)
            add(key: .customid, value: customid)
            add(key: .moderation, value: moderation)
            add(key: .enableactions, value: enableactions)
            add(key: .enableenterandexit, value: enableenterandexit)
            add(key: .enableprofanityfilter, value: enableprofanityfilter)
            add(key: .enableautoexpiresessions, value: enableautoexpiresessions)
            add(key: .roomisopen, value: roomisopen)
            add(key: .delaymessageseconds, value: delaymessageseconds)
            add(key: .throttle, value: throttle)
            add(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// Updates an existing room
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) The ID of the existing room
    ///
    /// - name: (optional) The name of the room
    ///
    /// - description: (optional) The description of the room
    ///
    /// - moderation: (optional) [premoderation/postmoderation] Defaults to post-moderation.
    ///
    /// - enableactions: (optional) [true/false] Turns action commands on or off
    ///
    /// - enableenterandexit: (optional) [true/false] Turn enter and exit events on or off. Disable for large rooms to reduce noise.
    ///
    /// - enableprofanityfilter: (optional) [default=true / false] Enables profanity filtering.
    ///
    /// - delaymessageseconds: (optional) [default=0] Puts a delay on messages from when they are submitted until they show up in the chat. Used for throttling.
    ///
    /// - roomisopen: (optional) [true/false] If false, users cannot perform any commands in the room, chat is suspended.
    ///
    /// **Warning** This method requires authentication
    ///
    public class UpdateRoomCloseARoom: ParametersBase<UpdateRoomCloseARoom.Fields, UpdateRoomCloseARoom> {
        public enum Fields {
            case roomid
            case name
            case description
            case moderation
            case enableactions
            case enableenterandexit
            case enableprofanityfilter
            case delaymessageseconds
            case roomisopen
            case userid
        }
        
        public let roomid: String   // REQUIRED
        public var name: String?
        public var description: String?
        public var moderation: String?
        public var enableactions: Bool?
        public var enableenterandexit: Bool?
        public var enableprofanityfilter: Bool?
        public var delaymessageseconds: Int?
        public var roomisopen: Bool? = false
        public var userid: String?
        
        public init(roomid: String, name: String? = nil, description: String? = nil, moderation: String? = nil, enableactions: Bool? = nil, enableenterandexit: Bool? = nil, enableprofanityfilter: Bool? = nil, delaymessageseconds: Int? = nil, roomisopen: Bool? = nil, userid: String? = nil) {
            self.roomid = roomid
            self.name = name
            self.description = description
            self.moderation = moderation
            self.enableactions = enableactions
            self.enableenterandexit = enableenterandexit
            self.enableprofanityfilter = enableprofanityfilter
            self.delaymessageseconds = delaymessageseconds
            self.roomisopen = roomisopen
            self.userid = userid
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> UpdateRoomCloseARoom {
            set(dictionary: dictionary)
            let ret = UpdateRoomCloseARoom(
                roomid: value(forKey: .roomid) ?? "",
                name: value(forKey: .name),
                description: value(forKey: .description),
                moderation: value(forKey: .moderation),
                enableactions: value(forKey: .enableactions),
                enableenterandexit: value(forKey: .enableenterandexit),
                enableprofanityfilter: value(forKey: .enableprofanityfilter),
                delaymessageseconds: value(forKey: .delaymessageseconds),
                roomisopen: value(forKey: .roomisopen)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .name, value: name)
            add(key: .description, value: description)
            add(key: .moderation, value: moderation)
            add(key: .enableactions, value: enableactions)
            add(key: .enableenterandexit, value: enableenterandexit)
            add(key: .enableprofanityfilter, value: enableprofanityfilter)
            add(key: .roomisopen, value: roomisopen)
            add(key: .delaymessageseconds, value: delaymessageseconds)
            
            return toDictionary
        }
    }
    
    /// List all the available public chat rooms
    ///
    /// Rooms can be public or private. This method lists all public rooms that everyone can see.
    ///
    /// **Parameters**
    ///
    /// - cursor: (optional) The first time you call list rooms, omit this property to start from the beginning. Call the method again passing in the value returned in the cursor field of the response to get the next page of results. If there are more results available, more will be true.
    ///
    /// - limit: (optional) Specify the number of items to return. Default is 200
    ///
    /// **Warning** This method requires authentication
    ///
    public class ListRooms: ParametersBase<ListRooms.Fields, ListRooms>  {
        public enum Fields {
            case cursor
            case limit
        }
        
        public var cursor: String?
        public var limit: Int?// =  200
        
        public init(cursor: String? = nil, limit: Int? = nil) {
            self.cursor = cursor
            self.limit = limit
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListRooms {
            set(dictionary: dictionary)
            let ret = ListRooms(
                cursor: value(forKey: .cursor),
                limit: value(forKey: .limit)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }

    }

    /// List all the participants in the specified room
    ///
    /// Use this method to cursor through the people who have subscribe to the room.
    ///
    /// To cursor through the results if there are many participants, invoke this function many times. Each result will return a cursor value and you can pass that value to the next invokation to get the next page of results. The result set will also include a next field with the full URL to get the next page, so you can just keep reading that and requesting that URL until you reach the end. When you reach the end, no more results will be returned or the result set will be less than maxresults and the next field will be empty.
    ///
    ///  **Parameters**
    ///
    ///  - roomid: (required)  room id that you want to list the participants
    ///
    ///  - cursor: (optional) you can pass that value to the next invokation to get the next page of results
    ///
    ///  - limit: (optional) default is 200
    ///
    /// **Warning** This method requires authentication
    ///
    public class ListRoomParticipants: ParametersBase<ListRoomParticipants.Fields, ListRoomParticipants> {
        public enum Fields {
            case roomid
            case cursor
            case limit
        }
        
        public let roomid: String   // REQUIRED
        public var cursor: String?// = ""
        public var limit: Int?// = 200
        
        public init(roomid: String, cursor: String? = nil, limit: Int? = nil) {
            self.roomid = roomid
            self.cursor = cursor
            self.limit = limit
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListRoomParticipants {
            set(dictionary: dictionary)
            let ret = ListRoomParticipants(
                roomid: value(forKey: .roomid) ?? "",
                cursor: value(forKey: .cursor),
                limit: value(forKey: .limit)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }
    
    /// List the rooms the user is subscribed to
    ///
    /// Use this method to cursor through all the rooms the user is subscribed to. This will include all rooms. If you want to build a private messaging experience, you can put custom tags on the rooms to separate out which are for private messenger and which are public group rooms.
    ///
    /// To cursor through the results if there are many participants, invoke this function many times. Each result will return a cursor value and you can pass that value to the next invokation to get the next page of results. The result set will also include a next field with the full URL to get the next page, so you can just keep reading that and requesting that URL until you reach the end. When you reach the end, no more results will be returned or the result set will be less than maxresults and the next field will be empty.
    ///
    ///  **Parameters**
    ///
    ///  - userid: (required)
    ///
    ///  - cursor: (optional) you can pass that value to the next invokation to get the next page of results
    ///
    ///  - limit: (optional) default is 200
    ///
    /// **Warning** This method requires authentication
    ///
    public class ListUserSubscribedRooms: ParametersBase<ListUserSubscribedRooms.Fields, ListUserSubscribedRooms> {
        public enum Fields {
            case userid
            case cursor
            case limit
        }
        
        public let userid: String   // REQUIRED
        public var cursor: String?// = ""
        public var limit: Int?// = 200
        
        public init(userid: String, cursor: String? = nil, limit: Int? = nil) {
            self.userid = userid
            self.cursor = cursor
            self.limit = limit
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListUserSubscribedRooms {
            set(dictionary: dictionary)
            let ret = ListUserSubscribedRooms(
                userid: value(forKey: .userid) ?? "",
                cursor: value(forKey: .cursor),
                limit: value(forKey: .limit)
            )
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
        
    }
    
    /// - This method enables you to download all of the events from a room in large batches. It should only be used if doing a data export.
    ///
    /// - This method returns a list of events sorted from oldest to newest.
    ///
    /// - This method returns all events, even those in the inactive state
    ///
    ///  **Parameters**
    ///
    ///  - roomid: (required)  Room id where you want event history to be listed
    ///
    ///  - limit: (optional) default is 100, maximum 2000
    ///
    ///  - cursor: (optional) If not provided, the most recent events will be returned. To get older events, call this method again using the cursor string returned from the previous call.
    ///
    public class ListEventHistory: ParametersBase<ListEventHistory.Fields, ListEventHistory> {
        public enum Fields {
            case roomid
            case cursor
            case limit
        }
        
        public let roomid: String   // REQUIRED
        public var cursor: String?// = ""
        public var limit: Int?// = 100
        
        public init(roomid: String, cursor: String? = nil, limit: Int? = nil) {
            self.roomid = roomid
            self.cursor = cursor
            self.limit = limit
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListEventHistory {
            set(dictionary: dictionary)
            let ret = ListEventHistory(
                roomid: value(forKey: .roomid) ?? "",
                cursor: value(forKey: .cursor),
                limit: value(forKey: .limit)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }

    /// This method allows you to go back in time to "scroll" in reverse through past messages. The typical use case for this method is to power the scroll-back feature of a chat window allowing the user to look at recent messages that have scrolled out of view. It's intended use is to retrieve small batches of historical events as the user is scrolling up.
    ///
    /// - This method returns a list of events sorted from newest to oldest.
    ///
    /// - This method excludes events that are not in the active state (for example if they are removed by a moderator)
    ///
    /// - This method excludes non-displayable events (reaction, replace, remove, purge)
    ///
    /// - This method will not return events that were emitted and then deleted before this method was called
    ///
    /// **Parameters**
    ///
    /// - roomid: (required)  Room id where you want previous events to be listed
    ///
    /// - limit: (optional) default is 100, maximum 500
    ///
    /// - cursor: (optional) If not provided, the most recent events will be returned. To get older events, call this method again using the cursor string returned from the previous call.
    ///
    public class ListPreviousEvents: ParametersBase<ListPreviousEvents.Fields, ListPreviousEvents> {
        public enum Fields {
            case roomid
            case cursor
            case limit
        }
        
        public let roomid: String   // REQUIRED
        public var cursor: String?
        public var limit: Int?// = 100
        
        public init(roomid: String, cursor: String? = nil, limit: Int? = nil) {
            self.roomid = roomid
            self.cursor = cursor
            self.limit = limit
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListPreviousEvents {
            set(dictionary: dictionary)
            let ret = ListPreviousEvents(
                roomid: value(forKey: .roomid) ?? "",
                cursor: value(forKey: .cursor),
                limit: value(forKey: .limit)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }
    
    /// - This method enables you to retrieve a small list of recent events by type. This is useful for things like fetching a list of recent announcements or custom event types without the need to scroll through the entire chat history.
    ///
    /// - This method returns a list of events sorted from newest to oldest.
    ///
    /// - This method returns only active events.
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) Room id where you want previous events to be listed
    ///
    /// - limit: (optional) default is 10, maximum 100
    ///
    /// - cursor: (optional) If not provided, the most recent events will be returned. To get older events, call this method again using the cursor string returned from the previous call.
    ///
    /// - eventtype: (required) Specify the chat event type you are filtering for. If you want to filter for a custom event type, specify 'custom' and then provide a value for the *customtype parameter
    ///
    /// - customtype: (optional) If you want to filter by custom type you must first specify 'custom' for the eventtype field. This will enable you to filter to find events of a custom type
    ///
    public class ListEventByType: ParametersBase<ListEventByType.Fields, ListEventByType> {
        public enum Fields {
            case roomid
            case eventtype
            case cursor
            case limit
            case customtype
        }
        
        public let roomid: String   // REQUIRED
        public let eventtype: EventType // REQUIRED
        public var cursor: String?
        public var limit: Int?// = 10
        public var customtype: String?
        
        public init(roomid: String, eventtype: EventType, cursor: String? = nil, limit: Int? = nil, customtype: String? = nil) {
            self.roomid = roomid
            self.eventtype = eventtype
            self.cursor = cursor
            self.limit = limit
            self.customtype = customtype
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListEventByType {
            set(dictionary: dictionary)
            let ret = ListEventByType(
                roomid: value(forKey: .roomid) ?? "",
                eventtype: value(forKey: .eventtype) ?? .speech,
                cursor: value(forKey: .cursor),
                limit: value(forKey: .limit),
                customtype: value(forKey: .customtype)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .eventtype, value: eventtype.rawValue)
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            add(key: .customtype, value: customtype)
            
            return toDictionary
        }
    }
    
    /// - This method enables you to retrieve an event using a timestamp.
    ///
    /// - You can optionally retrieve a small number of displayable events before and after the message at the requested timestamp.
    ///
    /// - This method returns a list of events sorted from oldest to newest.
    ///
    /// - This method returns only active events.
    ///
    /// - The timestamp is a high resolution timestamp accurate to the thousanth of a second. It is possible, but very unlikely, for two messages to have the same timestamp.
    ///
    /// - The method returns "timestampolder". This can be passed as the timestamp value when calling functions like this which accept a timestamp to retrieve data.
    ///
    /// - The method returns "timestampnewer". This can be passed as the timestamp value when calling this function again.
    ///
    /// - The method returns "cursorpolder". This can be passed as the cursor to ethods that accept an events-sorted-by-time cursor.
    ///
    /// - The method returns "cursornewer". This can be passed as the cursor to methods that accept an events-sorted-by-time cursor.
    ///
    /// **Limitation**
    ///
    /// If you pass in 0 for limitolder you won't get any older events than your timestamp and hasmoreolder will always be false because the API will not query for older events. If you pass in 0 for limitnewer you won't get any newer events than your timestamp and hasmorenewer will always be false because the API will not query for newer events
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) Room id where you want previous events to be listed
    ///
    /// - ts: (required) If not provided, the most recent events will be returned. To get older events, call this method again using the cursor string returned from the previous call
    ///
    /// - limitolder: (optional) Defaults to 0, maximum 100.
    ///
    /// - limitnewer : (optional) Defaults to 0, maximum 100
    ///
    public class ListEventByTimestamp: ParametersBase<ListEventByTimestamp.Fields, ListEventByTimestamp> {
        public enum Fields {
            case roomid
            case ts
            case limitolder
            case limitnewer
        }
        
        public let roomid: String   // REQUIRED
        public let timestamp: Int   // REQUIRED
        public var limitolder: Int?// = 0
        public var limitnewer: Int?// = 0
        
        public init(roomid: String, timestamp: Int, limitolder: Int? = nil, limitnewer: Int? = nil) {
            self.roomid = roomid
            self.timestamp = timestamp
            self.limitolder = limitolder
            self.limitnewer = limitnewer
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListEventByTimestamp {
            set(dictionary: dictionary)
            let ret = ListEventByTimestamp(
                roomid: value(forKey: .roomid) ?? "",
                timestamp: value(forKey: .ts) ?? 0,
                limitolder: value(forKey: .limitolder),
                limitnewer: value(forKey: .limitnewer)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .limitolder, value: limitolder)
            add(key: .limitnewer, value: limitnewer)
            
            return toDictionary
        }
    }
    
    /// Join A Room
    ///
    /// You want your chat experience to open fast. The steps to opening a chat experience are:
    ///
    /// - Create Room
    ///
    /// - Create User
    ///
    /// - Join Room (user gets permission to access events data from the room)
    ///
    /// - Get Recent Events to display in your app
    ///
    /// - If you have already created the room (step 1) then you can perform steps 2 - 4 using join room
    ///
    /// **DATA PARAMETERS**
    ///
    /// Provide a unique user ID string and chat handle string. If this is the first time the user ID has been used a new user record will be created for the user. Whenever the user creates an event in the room by doing an action like saying something, the user information will be returned.
    ///
    /// You can optionally also provide a URL to an image and a URL to a profile.
    ///
    /// If you provide user information and the user already exists in the database, the user will be updated with the new information.
    ///
    /// The user will be added to the list of participants in the room and the room participant count will increase.
    ///
    /// The user will be removed from the room automatically after some time if the user doesn't perform any operations.
    ///
    /// Users can only execute commands in the room if they have joined the room.
    ///
    /// When a logged in user joins a room an entrance event is generated in the room.
    ///
    /// When a logged in user leaves a room, an exit event is generated in the room
    ///
    /// **Creating A New User:** You have the option to create or update an existing user during join.
    ///
    /// **Parameters**
    ///
    /// - limit: (optional) Defaults to 50. This limits the number of previous messages returned when joining the room.
    ///
    /// - userid: (required) If the userid is new then the user will be created. If the userid is already in use in the database then the user will be updated.
    ///
    /// - handle: (Optional) A unique string representing the user that is easy for other users to type.
    ///
    ///     - Example @GeorgeWashington could be the handle but Display Name could be "Wooden Teef For The Win".
    ///
    ///     - If you are creating a user and you don't specify a handle, the system will generate one for you (using Display Name as basis if you provide that).
    ///
    ///     - If you request a handle and it's already in use a new handle will be generated for you by adding a number from 1-99 and returned.
    ///
    ///     - If the handle can't be generated because all the options 1-99 on the end of it are taken then the request will be rejected with BadRequest status code.
    ///
    ///     - Only these characters may be used: *"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"*
    ///
    /// - displayname: (optional) This is the desired name to display, typically the real name of the person.
    ///
    /// - pictureurl: (optional) The URL to the picture for this user.
    ///
    /// - profileurl: (optional) The profileurl for this user.
    ///
    /// **Warning** This method requires authentication
    ///
    public class JoinRoom: ParametersBase<JoinRoom.Fields, JoinRoom> {
        public enum Fields {
            case roomid
            case userid
            case handle
            case displayname
            case pictureurl
            case profileurl
            case limit
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public var handle: String?
        public var displayname: String?
        public var pictureurl: URL?
        public var profileurl: URL?
        public var limit: Int?// = 50
        
        public init(roomid: String, userid: String, handle: String? = nil, displayname: String? = nil, pictureurl: URL? = nil, profileurl: URL? = nil, limit: Int? = nil) {
            self.roomid = roomid
            self.userid = userid
            self.handle = handle
            self.displayname = displayname
            self.pictureurl = pictureurl
            self.profileurl = profileurl
            self.limit = limit
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> JoinRoom {
            set(dictionary: dictionary)
            let ret = JoinRoom(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? "",
                handle: value(forKey: .handle),
                displayname: value(forKey: .displayname),
                pictureurl: value(forKey: .pictureurl),
                profileurl: value(forKey: .profileurl),
                limit: value(forKey: .limit)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            add(key: .handle, value: handle)
            add(key: .displayname, value: displayname)
            add(key: .pictureurl, value: pictureurl?.absoluteString)
            add(key: .profileurl, value: profileurl?.absoluteString)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }
    
    /// Join A Room By Custom ID
    ///
    /// This method is the same as Join Room, except you can use your customid
    ///
    /// The benefit of this method is you don't need to query to get the roomid using customid, and then make another call to join the room. This eliminates a request and enables you to bring your chat experience to your user faster.
    ///
    /// You want your chat experience to open fast. The steps to opening a chat experience are:
    ///
    /// 1. Create Room
    ///
    /// 2. Create User
    ///
    /// 3. Join Room (user gets permission to access events data from the room)
    ///
    /// 4. Get Recent Events to display in your app
    ///
    /// If you have already created the room (step 1) then you can perform steps 2 - 4 using join room.
    ///
    /// When you attempt to join the room, if the userid you provide does not exist then a user will be created for you automatically.
    ///
    /// If you provide a Display Name and you do not provide a handle then the display name will automatically be used to generate a handle for you. If you do not provide a display name or a handle then a 16 character handle will be automatically generated for you.
    ///
    /// **DATA PARAMETERS**
    ///
    /// Provide a unique user ID string and chat handle string. If this is the first time the user ID has been used a new user record will be created for the user. Whenever the user creates an event in the room by doing an action like saying something, the user information will be returned.
    ///
    /// You can optionally also provide a URL to an image and a URL to a profile.
    ///
    /// If you provide user information and the user already exists in the database, the user will be updated with the new information.
    ///
    /// The user will be added to the list of participants in the room and the room participant count will increase.
    ///
    /// The user will be removed from the room automatically after some time if the user doesn't perform any operations.
    ///
    /// Users can only execute commands in the room if they have joined the room.
    ///
    /// When a logged in user joins a room an entrance event is generated in the room.
    ///
    /// When a logged in user leaves a room, an exit event is generated in the room.
    ///
    /// **Creating A New User:** You have the option to create or update an existing user during join.
    ///
    /// **Parameters**
    ///
    /// - limit: (optional) Defaults to 50. This limits the number of previous messages returned when joining the room.
    ///
    /// - userid: (required). If the userid is new then the user will be created. If the userid is already in use in the database then the user will be updated.
    ///
    /// - handle: (Optional) A unique string representing the user that is easy for other users to type.
    ///
    ///     - Example @GeorgeWashington could be the handle but Display Name could be "Wooden Teef For The Win".
    ///
    ///     - If you are creating a user and you don't specify a handle, the system will generate one for you (using Display Name as basis if you provide that).
    ///
    ///     - If you request a handle and it's already in use a new handle will be generated for you by adding a number from 1-99 and returned.
    ///
    ///     - If the handle can't be generated because all the options 1-99 on the end of it are taken then the request will be rejected with BadRequest status code.
    ///
    ///     - Only these characters may be used: *"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"*
    ///
    /// - displayname: (optional) This is the desired name to display, typically the real name of the person.
    ///
    /// - pictureurl: (optional) The URL to the picture for this user.
    ///
    /// - profileurl: (optional) The profileurl for this user.
    ///
    /// **Warning** This method requires authentication
    ///
    public class JoinRoomByCustomId: ParametersBase<JoinRoomByCustomId.Fields, JoinRoomByCustomId> {
        public enum Fields {
            case customid
            case userid
            case handle
            case displayname
            case pictureurl
            case profileurl
            case limit
        }
       
        public let customid: String // REQUIRED
        public let userid: String   // REQUIRED
        public var handle: String?
        public var displayname: String?
        public var pictureurl: URL?
        public var profileurl: URL?
        public var limit: Int?// = 50
        
        public init(customid: String, userid: String, handle: String? = nil, displayname: String? = nil, pictureurl: URL? = nil, profileurl: URL? = nil, limit: Int? = nil) {
            self.customid = customid
            self.userid = userid
            self.handle = handle
            self.displayname = displayname
            self.pictureurl = pictureurl
            self.profileurl = profileurl
            self.limit = limit
        }
       
        override public func from(dictionary: [AnyHashable: Any]) -> JoinRoomByCustomId {
            set(dictionary: dictionary)
            let ret = JoinRoomByCustomId(
                customid: value(forKey: .customid) ?? "",
                userid: value(forKey: .userid) ?? "",
                handle: value(forKey: .handle),
                displayname: value(forKey: .displayname),
                pictureurl: value(forKey: .pictureurl),
                profileurl: value(forKey: .profileurl),
                limit: value(forKey: .limit)
            )
            
            return ret
        }
       
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .customid, value: customid)
            addRequired(key: .userid, value: userid)
            add(key: .handle, value: handle)
            add(key: .displayname, value: displayname)
            add(key: .pictureurl, value: pictureurl?.absoluteString)
            add(key: .profileurl, value: profileurl?.absoluteString)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
     }
    
    /// Exit a Room
    ///
    /// This method should be called to remove a user from a room. This will cause an EXIT event to be broadcast in the room and this user will no longer show up in the list of attendees in the room.
    ///
    ///  **Parameters**
    ///
    ///  - roomid: (required)  Room id that you want to exit
    ///
    ///  - userid: (required) user id specific to App
    ///
    /// **Warning** This method requires authentication
    ///
    public class ExitRoom: ParametersBase<ExitRoom.Fields, ExitRoom> {
        public enum Fields {
            case roomid
            case userid
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        
        public init(roomid: String, userid: String) {
            self.roomid = roomid
            self.userid = userid
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExitRoom {
            set(dictionary: dictionary)
            let ret = ExitRoom(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    
    /// Get the Recent Updates to a Room
    ///
    /// You can use this function to poll the room to get the recent events in the room. The recommended poll interval is 500ms. Each event has an ID and a timestamp. To detect new messages using polling, call this function and then process items with a newer timestamp than the most recent one you have already processed.
    ///
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a;
    ///
    /// - enter event: A user has joined the room.
    ///
    /// - exit event: A user has exited chat.
    ///
    /// - message: A user has communicated a message.
    ///
    /// - reply: A user sent a message in response to another user.
    ///
    /// - reaction: A user has reacted to a message posted by another user.
    ///
    /// - action: A user is performing an ACTION (emote) alone or with another user.
    ///
    ///  **Enter and Exit Events**
    ///
    ///  Enter and Exit events may not be sent if the room is expected to have a very large number of users.
    ///
    ///  **Parameters**
    ///
    ///  - roomid: (required) Room id that you want to update
    ///
    ///  - cursor: (optional) Used in cursoring through the list. Gets the next batch of users. Read 'nextCur' property of result set and pass as cursor value.
    ///
    ///  - limit: (optional) Number of events to return. Default is 100, maximum is 500
    ///
    /// **Warning** This method requires authentication
    ///
    public class GetUpdates: ParametersBase<GetUpdates.Fields, GetUpdates> {
        public enum Fields {
            case roomid
            case cursor
            case limit
        }
        
        public let roomid: String   // REQUIRED
        public var cursor: String?
        public var limit: Int?// = 100
        
        public init(roomid: String, cursor: String? = nil, limit: Int? = nil) {
            self.roomid = roomid
            self.cursor = cursor
            self.limit = limit
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetUpdates {
            set(dictionary: dictionary)
            let ret = GetUpdates(
                roomid: value(forKey: .roomid) ?? "",
                cursor: value(forKey: .cursor),
                limit: value(forKey: .limit)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .limit, value: limit)
            add(key: .cursor, value: cursor)
            
            return toDictionary
        }
    }
    
    /// Get the Recent Updates to a Room
    ///
    /// You can use this function to poll the room to get the recent events in the room. The recommended poll interval is 500ms. Each event has an ID and a timestamp. To detect new messages using polling, call this function and then process items with a newer timestamp than the most recent one you have already processed.
    ///
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a;
    ///
    /// - enter event: A user has joined the room.
    ///
    /// - exit event: A user has exited chat.
    ///
    /// - message: A user has communicated a message.
    ///
    /// - reply: A user sent a message in response to another user.
    ///
    /// - reaction: A user has reacted to a message posted by another user.
    ///
    /// - action: A user is performing an ACTION (emote) alone or with another user.
    ///
    ///  **Enter and Exit Events**
    ///
    ///  Enter and Exit events may not be sent if the room is expected to have a very large number of users.
    ///
    ///  **Parameters**
    ///
    ///  - limit: (optional) Specify the number of events to return.
    ///
    ///  - cursor: (optional) If provided will return events that are newer than what the cursor points to.
    ///
    /// **Warning** This method requires authentication
    ///
    public class GetMoreUpdates: ParametersBase<GetMoreUpdates.Fields, GetMoreUpdates> {
        public enum Fields {
            case roomid
            case limit
            case cursor
        }
        
        public let roomid: String   // REQUIRED
        public var limit: Int?// = 100
        public var cursor: String?
        
        public init(roomid: String, limit: Int? = nil, cursor: String? = nil) {
            self.roomid = roomid
            self.limit = limit
            self.cursor = cursor
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetMoreUpdates {
            set(dictionary: dictionary)
            let ret = GetMoreUpdates(
                roomid: value(forKey: .roomid) ?? "",
                limit: value(forKey: .limit),
                cursor: value(forKey: .cursor)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit ?? 100)
            
            return toDictionary
        }
    }
    
    /// Executes a command in a chat room
    ///
    /// **Precondition** The user must JOIN the room first with a call to Join Room. Otherwise you'll receive HTTP Status Code PreconditionFailed (412)
    ///
    /// **API UPDATES**
    /// - replyto: This is deprecated. For replies use Quoted Reply or Threaded Reply. For most use cases, Quoted Reply is the recommended approach.
    ///
    /// **SENDING A MESSAGE**
    ///
    ///  - Send any text that doesn't start with a reserved symbol to perform a SAY command.
    ///  - Use this API call to REPLY to existing messages
    ///  - Use this API call to perform ACTION commands
    ///  - Use this API call to perform ADMIN commands
    ///
    ///  *example*
    ///  These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World
    ///
    ///  **ACTION COMMANDS**
    ///
    ///  - Action commands start with the / character
    ///
    /// *example*
    ///
    /// `/dance nicole`
    /// User sees: `You dance with Nicole`
    /// Nicole sees: `(user's handle) dances with you`
    /// Everyone else sees: `(user's handle) dances with Nicole`
    ///
    /// This requires that the action command dance is on the approved list of commands and Nicole is the handle of a participant in the room, and that actions are allowed in the room.
    ///
    /// **ADMIN COMMANDS**
    ///
    ///  - These commands start with the * character
    ///
    /// *example*
    ///
    /// - ban : This bans the user from the entire chat experience (all rooms).
    ///
    /// - restore : This restores the user to the chat experience (all rooms).
    ///
    /// - purge : This deletes all messages from the specified user.
    ///
    /// - deleteallevents : This deletes all messages in this room.
    ///
    ///  **Parameters**
    ///
    /// - command: (required) The command to execute. See examples above.
    ///
    /// - userid: (required) The userid of user who is executing the command. The user must have joined the room first.
    ///
    /// - eventtype: (optional, default = speech) By default, the API will determine the type of event by processing your command. However you can send custom commands.
    ///
    ///     - custom : This indicates you will be using a custom event type.
    ///
    ///     - announcement : This indicates the event is of type announcement.
    ///
    ///     - ad : Use this event type to push an advertisement. Use the CustomPayload property to specify parameters for your add.
    ///
    /// - customtype: (optional) A string having meaning to your app that represents a custom type of event defined by you. You must specify "custom" as the eventtype to use this. If you don't, the event type will be forced to custom anyway.
    ///
    /// - custompayload: (optional) A string (XML or JSON usually) representing custom data for your application to use.
    ///
    /// - replyto: (optional) Use this field to provide the EventID of an event you want to reply to. Replies have a different event type and contain a copy of the original event.
    ///
    /// - moderation: (optional) Use this field to override the moderation state of the chat event. Use this when you have already inspected the content. Use one of the values below.
    ///
    ///     - approved : The content has already been approved by a moderator and it should not be sent to the moderation queue if users report it since the decision was already made to approve it.
    ///
    ///     - prescreened : The content was prescreened, but not approved. This means it can still be flagged for moderation queue by the users. This state allows a data analyst to distinguish between content that was approved by a moderator and content that went through a filtering process but wasn't explicitly approved or rejected.
    ///
    ///     - rejected : The content has been rejected by a moderator and it should not be broadcast into the chat stream, but it should be saved to the chat room history for future analysis or audit trail purposes.
    ///
    /// **RESPONSE CODES**
    ///
    /// 200 | OK : Sweet, sweet success.
    ///
    /// 400 | BadRequest : Something is wrong with your request. View response message and errors list for details.
    ///
    /// 403 | Forbidden : The userid issuing the request is banned from chatting in this room (or is banned globally).
    ///
    /// 405 | MethodBlocked : The method was blocked because it contained profanity and filtermode was set to 'block'.
    ///
    /// 409 | Conflict : The customid of your event is already in use.
    ///
    /// 412 | PreconditionFailed : User must JOIN the room before executing a chat command.
    ///
    public class ExecuteChatCommand: ParametersBase<ExecuteChatCommand.Fields, ExecuteChatCommand> {
        public enum Fields {
            case roomid
            case command
            case userid
            case moderation
            case eventtype
            case customtype
            case customid
            case custompayload
        }
        
        public let roomid: String   // REQUIRED
        public let command: String  // REQUIRED
        public let userid: String   // REQUIRED
        public var moderation: String?
        public var eventtype: EventType?
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?
        
        public init(roomid: String, command: String, userid: String, moderation: String? = nil, eventtype: EventType? = nil, customtype: String? = nil, customid: String? = nil, custompayload: String? = nil) {
            self.roomid = roomid
            self.command = command
            self.userid = userid
            self.moderation = moderation
            self.eventtype = eventtype
            self.customtype = customtype
            self.customid = customid
            self.custompayload = custompayload
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteChatCommand {
            set(dictionary: dictionary)
            let ret = ExecuteChatCommand(
                roomid: value(forKey: .roomid) ?? "",
                command: value(forKey: .command) ?? "",
                userid: value(forKey: .userid) ?? "",
                moderation: value(forKey: .moderation),
                eventtype: value(forKey: .eventtype),
                customtype: value(forKey: .customtype),
                customid: value(forKey: .customid),
                custompayload: value(forKey: .custompayload)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .moderation, value: moderation)
            add(key: .eventtype, value: eventtype?.rawValue)
            add(key: .customtype, value: customtype)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)
            
            return toDictionary
        }
    }
    
    /// Executes a command in a chat room
    ///
    /// **Precondition** The user must JOIN the room first with a call to Join Room. Otherwise you'll receive HTTP Status Code PreconditionFailed (412)
    ///
    /// **API UPDATES**
    /// - replyto: This is deprecated. For replies use Quoted Reply or Threaded Reply. For most use cases, Quoted Reply is the recommended approach.
    ///
    /// SENDING A MESSAGE:
    ///
    ///  - Send any text that doesn't start with a reserved symbol to perform a SAY command.
    ///  - Use this API call to REPLY to existing messages
    ///  - Use this API call to perform ACTION commands
    ///  - Use this API call to perform ADMIN commands
    ///
    ///  *example*
    ///  These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World
    ///
    ///  **ACTION COMMANDS**
    ///
    ///  - Action commands start with the / character
    ///
    /// *example*
    ///
    /// `/dance nicole`
    /// User sees: `You dance with Nicole`
    /// Nicole sees: `(user's handle) dances with you`
    /// Everyone else sees: `(user's handle) dances with Nicole`
    ///
    /// This requires that the action command dance is on the approved list of commands and Nicole is the handle of a participant in the room, and that actions are allowed in the room.
    ///
    /// **ADMIN COMMANDS**
    ///
    ///  - These commands start with the * character
    ///
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a... enter event: A user has joined the room.
    ///
    /// *example*
    ///
    /// - ban : This bans the user from the entire chat experience (all rooms).
    ///
    /// - restore : This restores the user to the chat experience (all rooms).
    ///
    /// - purge : This deletes all messages from the specified user.
    ///
    /// - deleteallevents : This deletes all messages in this room.
    ///
    ///  **Parameters**
    ///
    /// - command: (required) The command to execute. See examples above.
    ///
    /// - userid: (required) The userid of user who is executing the command. The user must have joined the room first.
    ///
    /// - eventtype: (optional, default = speech) By default, the API will determine the type of event by processing your command. However you can send custom.
    ///  commands.
    ///
    ///     - custom : This indicates you will be using a custom event type.
    ///
    ///     - announcement : This indicates the event is of type announcement.
    ///
    ///     - ad : Use this event type to push an advertisement. Use the CustomPayload property to specify parameters for your add.
    ///
    ///     - customtype: (optional) A string having meaning to your app that represents a custom type of event defined by you. You must specify "custom" as the eventtype to use this. If you don't, the event type will be forced to custom anyway.
    ///
    /// - custompayload: (optional) A string (XML or JSON usually) representing custom data for your application to use.
    ///
    /// - replyto: (optional) Use this field to provide the EventID of an event you want to reply to. Replies have a different event type and contain a copy of the original event.
    ///
    /// - moderation: (optional) Use this field to override the moderation state of the chat event. Use this when you have already inspected the content. Use one of the values below.
    ///
    ///     - approved : The content has already been approved by a moderator and it should not be sent to the moderation queue if users report it since the decision was already made to approve it.
    ///
    ///     - prescreened : The content was prescreened, but not approved. This means it can still be flagged for moderation queue by the users. This state allows a data analyst to distinguish between content that was approved by a moderator and content that went through a filtering process but wasn't explicitly approved or rejected.
    ///
    ///     - rejected : The content has been rejected by a moderator and it should not be broadcast into the chat stream, but it should be saved to the chat room history for future analysis or audit trail purposes.
    ///
    /// **RESPONSE CODES**
    ///
    /// 200 | OK : Sweet, sweet success.
    ///
    /// 400 | BadRequest : Something is wrong with your request. View response message and errors list for details.
    ///
    /// 403 | Forbidden : The userid issuing the request is banned from chatting in this room (or is banned globally).
    ///
    /// 405 | MethodBlocked : The method was blocked because it contained profanity and filtermode was set to 'block'.
    ///
    /// 409 | Conflict : The customid of your event is already in use.
    ///
    /// 412 | PreconditionFailed : User must JOIN the room before executing a chat command.
    ///
    public class ExecuteDanceAction: ParametersBase<ExecuteDanceAction.Fields, ExecuteDanceAction> {
        public enum Fields {
            case roomid
            case command
            case userid
            case customtype
            case customid
            case custompayload
        }
        
        public let roomid: String   // REQUIRED
        public let command: String  // REQUIRED
        public let userid: String   // REQUIRED
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?
        
        public init(roomid: String, command: String, userid: String, customtype: String? = nil, customid: String? = nil, custompayload: String? = nil) {
            self.roomid = roomid
            self.command = command
            self.userid = userid
            self.customtype = customtype
            self.customid = customid
            self.custompayload = custompayload
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteDanceAction {
            set(dictionary: dictionary)
            let ret = ExecuteDanceAction(
                roomid: value(forKey: .roomid) ?? "",
                command: value(forKey: .command) ?? "",
                userid: value(forKey: .userid) ?? "",
                customtype: value(forKey: .customtype),
                customid: value(forKey: .customid),
                custompayload: value(forKey: .custompayload)
            )

            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .customtype, value: customtype)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)
            
            return toDictionary
        }
    }
    

    /// Quotes an existing message and republishes it with a new message
    ///
    /// This method is provided to support a chat experience where a person wants to reply to another person, and the reply is inline with the rest of chat, but contains a copy of all or part of the original message you are replying to. You can see this behavior in WhatsApp and iMessage. This way, when viewing the reply, the user doesn't need to scroll up searching conversation history for the context (the parent the reply is addresssing).
    ///
    ///
    /// **Parameters**
    ///
    /// - eventid: (required) The ID of the event you are quoting
    ///
    /// - userid: (required) The userid of the user who is publishing the quoted reply.
    ///
    /// - body: (required) The contents of the reply for the quoted reply. Cannot be empty.
    ///
    /// - customid: (optional) Assigns a custom ID to the quoted reply event.
    ///
    /// - custompayload: (optional) Attach a custom payload string to the quoted reply such as JSON or XML.
    ///
    /// - customfield1: (optional) Use this field however you wish.
    ///
    /// - customfield2: (optional) Use this field however you wish.
    ///
    /// - customtags: (optional) An array of strings, use this field however you wish.
    ///
    public class SendQuotedReply: ParametersBase<SendQuotedReply.Fields, SendQuotedReply> {
        public enum Fields {
            case roomid
            case eventid
            case userid
            case body
            case customid
            case custompayload
            case customfield1
            case customfield2
            case customtags
        }
        
        public let roomid: String   // REQUIRED
        public let eventid: String  // REQUIRED
        public let userid: String   // REQUIRED
        public let body: String     // REQUIRED
        public var customid: String?
        public var custompayload: String?
        public var customfield1: String?
        public var customfield2: String?
        public var customtags: String?
        
        public init(roomid: String, eventid: String, userid: String, body: String, customid: String? = nil, custompayload: String? = nil, customfield1: String? = nil, customfield2: String? = nil, customtags: String? = nil) {
            self.roomid = roomid
            self.eventid = eventid
            self.userid = userid
            self.body = body
            self.customid = customid
            self.custompayload = custompayload
            self.customfield1 = customfield1
            self.customfield2 = customfield2
            self.customtags = customtags
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> SendQuotedReply {
            set(dictionary: dictionary)
            let ret = SendQuotedReply(
                roomid: value(forKey: .roomid) ?? "",
                eventid: value(forKey: .eventid) ?? "",
                userid: value(forKey: .userid) ?? "",
                body: value(forKey: .body) ?? "",
                customid: value(forKey: .customid),
                custompayload: value(forKey: .custompayload),
                customfield1: value(forKey: .customfield1),
                customfield2: value(forKey: .customfield2),
                customtags: value(forKey: .customtags)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)
            add(key: .customfield1, value: customfield1)
            add(key: .customfield2, value: customfield2)
            add(key: .customtags, value: customtags)
            
            return toDictionary
        }
    }
    

    /// Creates a threaded reply to another message event
    ///
    /// The purpose of this method is to enable support of a sub-chat within the chat room. You can use it to split off the conversation into a nested conversation. You can build a tree structure of chat messages and replies, but it is recommended not to build experiences deeper than parent and child conversation level or it becomes complex for the users to follow.
    ///
    /// Replies do not support admin or action commands
    ///
    /// **Parameters**
    ///
    /// - eventid: (required) The ID of the event you are quoting
    ///
    /// - userid: (required) The userid of the user who is publishing the quoted reply.
    ///
    /// - body: (required) The contents of the reply for the quoted reply. Cannot be empty.
    ///
    /// - customid: (optional) Assigns a custom ID to the quoted reply event.
    ///
    /// - custompayload: (optional) Attach a custom payload string to the quoted reply such as JSON or XML.
    ///
    /// - customfield1: (optional) Use this field however you wish.
    ///
    /// - customfield2: (optional) Use this field however you wish.
    ///
    /// - customtags: (optional) An array of strings, use this field however you wish.
    ///
    public class SendThreadedReply: ParametersBase<SendThreadedReply.Fields, SendThreadedReply> {
        public enum Fields {
            case roomid
            case eventid
            case userid
            case body
            case customid
            case custompayload
            case customfield1
            case customfield2
            case customtags
        }
        
        public let roomid: String       // REQUIRED
        public let eventid: String      // REQUIRED
        public let userid: String       // REQUIRED
        public let body: String         // REQUIRED
        public var customid: String?
        public var custompayload: String?
        public var customfield1: String?
        public var customfield2: String?
        public var customtags: String?
        
        public init(roomid: String, eventid: String, userid: String, body: String, customid: String? = nil, custompayload: String? = nil, customfield1: String? = nil, customfield2: String? = nil, customtags: String? = nil) {
            self.roomid = roomid
            self.eventid = eventid
            self.userid = userid
            self.body = body
            self.customid = customid
            self.custompayload = custompayload
            self.customfield1 = customfield1
            self.customfield2 = customfield2
            self.customtags = customtags
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> SendThreadedReply {
            set(dictionary: dictionary)
            let ret = SendThreadedReply(
                roomid: value(forKey: .roomid) ?? "",
                eventid: value(forKey: .eventid) ?? "",
                userid: value(forKey: .userid) ?? "",
                body: value(forKey: .body) ?? "",
                customid: value(forKey: .customid),
                custompayload: value(forKey: .custompayload),
                customfield1: value(forKey: .customfield1),
                customfield2: value(forKey: .customfield2),
                customtags: value(forKey: .customtags)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)
            add(key: .customfield1, value: customfield1)
            add(key: .customfield2, value: customfield2)
            add(key: .customtags, value: customtags)
            
            return toDictionary
        }
    }
    
    /// Gets a list of users messages
    ///
    /// The purpose of this method is to get a list of messages or comments by a user, with count of replies and reaction data. This way, you can easily make a screen in your application that shows the user a list of their comment contributions and how people reacted to it.
    ///
    ///  **Parameters**
    ///
    ///  - roomid: (required)  Room id, in which you want to fetch messages
    ///
    ///  - userid: (required) user id, against which you want to fetch messages
    ///
    ///  - cursor: (optional) Used in cursoring through the list. Gets the next batch of users. Read 'nextCur' property of result set and pass as cursor value.
    ///
    ///  - limit: (optional) default 200
    ///
    /// **Warning** This method requires authentication
    ///
    public class ListMessagesByUser: ParametersBase<ListMessagesByUser.Fields, ListMessagesByUser> {
        public enum Fields {
            case cursor
            case limit
            case userid
            case roomid
        }
        
        public let roomid: String   // REQUIRED
        public let userId: String   // REQUIRED
        public var cursor: String?
        public var limit: Int?// = 200
        
        public init(roomid: String, userId: String, cursor: String? = nil, limit: Int? = nil) {
            self.roomid = roomid
            self.userId = userId
            self.cursor = cursor
            self.limit = limit
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListMessagesByUser {
            set(dictionary: dictionary)
            let ret = ListMessagesByUser(
                roomid: value(forKey: .roomid) ?? "",
                userId: value(forKey: .userid) ?? "",
                cursor: value(forKey: .cursor),
                limit: value(forKey: .limit)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }
    
    /// Set Deleted (LOGICAL DELETE)
    ///
    /// Everything in a chat room is an event. Each event has a type. Events of type "speech, reply, quote" are considered "messages".
    ///
    /// Use logical delete if you want to flag something as deleted without actually deleting the message so you still have the data. When you use this method:
    ///
    /// - The message is not actually deleted. The comment is flagged as deleted, and can no longer be read, but replies are not deleted.
    ///
    /// - If flag "permanentifnoreplies" is true, then it will be a permanent delete instead of logical delete for this comment if it has no children.
    ///
    /// - If you use "permanentifnoreplies" = true, and this comment has a parent that has been logically deleted, and this is the only child, then the parent will also be permanently deleted (and so on up the hierarchy of events).
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) The ID of the room containing the event
    ///
    /// - eventid: (required) The unique ID of the chat event to delete. The user posting the delete request must be the owner of the event or have moderator permission
    ///
    /// - userid: (required) This is the application specific user ID of the user deleting the comment. Must be the owner of the message event or authorized moderator.
    ///
    /// - deleted: (required) Set to true or false to flag the comment as deleted. If a comment is deleted, then it will have the deleted field set to true, in which case the contents of the event message should not be shown and the body of the message will not be returned by the API by default. If a previously deleted message is undeleted, the flag for deleted is set to false and the original comment body is returned
    ///
    /// - permanentifnoreplies: (optional) If this optional parameter is set to "true", then if this event has no replies it will be permanently deleted instead of logically deleted. If a permanent delete is performed, the result will include the field "permanentdelete=true"
    ///
    /// If you want to mark a comment as deleted, and replies are still visible, use "true" for the logical delete value. If you want to permanently delete the message and all of its replies, pass false
    public class FlagEventLogicallyDeleted: ParametersBase<FlagEventLogicallyDeleted.Fields, FlagEventLogicallyDeleted> {
        public enum Fields {
            case roomid
            case eventid
            case userid
            case deleted
            case permanentifnoreplies
        }
        
        public let roomid: String   // REQUIRED
        public let eventid: String  // REQUIRED
        public let userid: String   // REQUIRED
        public let deleted: Bool    // REQUIRED
        public var permanentifnoreplies: Bool?
        
        public init(roomid: String, eventid: String, userid: String, deleted: Bool, permanentifnoreplies: Bool? = nil) {
            self.roomid = roomid
            self.eventid = eventid
            self.userid = userid
            self.deleted = deleted
            self.permanentifnoreplies = permanentifnoreplies
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> FlagEventLogicallyDeleted {
            set(dictionary: dictionary)
            let ret = FlagEventLogicallyDeleted(
                roomid: value(forKey: .roomid) ?? "",
                eventid: value(forKey: .eventid) ?? "",
                userid: value(forKey: .userid) ?? "",
                deleted: value(forKey: .deleted) ?? false,
                permanentifnoreplies: value(forKey: .permanentifnoreplies)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .deleted, value: deleted)
            add(key: .permanentifnoreplies, value: permanentifnoreplies)
            
            return toDictionary
        }
    }
    
    /// Deletes an event from the room.
    ///
    /// This does not DELETE the message. It flags the message as moderator removed.
    ///
    /// **Parameters**
    ///
    /// - roomid: (required)  the room id in which you want to remove the message
    ///
    /// - eventId: (required) the message you want to remove.
    ///
    /// - userid: (optional) If provided, a check will be made to enforce this userid (the one deleting the event) is the owner of the event or has elevated permissions. If null, it assumes your business service made the determination to delete the event. If it is not provided this authorization check is bypassed.
    ///
    /// **Warning** This method requires authentication
    ///
    public class PermanentlyDeleteEvent: ParametersBase<PermanentlyDeleteEvent.Fields, PermanentlyDeleteEvent> {
        public enum Fields {
            case roomid
            case eventid
            case userid
        }
        
        public let roomid: String   // REQUIRED
        public let eventid: String  // REQUIRED
        public let userid: String   // REQUIRED
        
        public init(roomid: String, eventid: String, userid: String) {
            self.roomid = roomid
            self.eventid = eventid
            self.userid = userid
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> PermanentlyDeleteEvent {
            set(dictionary: dictionary)
            let ret = PermanentlyDeleteEvent(
                roomid: value(forKey: .roomid) ?? "",
                eventid: value(forKey: .eventid) ?? "",
                userid: value(forKey: .userid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// Deletes all the events in a room.
    ///
    ///  **Parameters**
    ///
    /// - roomid: (required)
    ///
    /// - userid: (required) the id of the owner of the messages
    ///
    /// - password: (required) a valid admin password
    ///
    public class DeleteAllEvents: ParametersBase<DeleteAllEvents.Fields, DeleteAllEvents> {
        public enum Fields {
            case roomid
            case command
            case userid
            case password
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public var password: String?
        
        private let command: String // "*deleteallevents $password"
        
        public init(roomid: String, userid: String, password: String? = nil) {
            self.roomid = roomid
            self.userid = userid
            self.password = password
            
            self.command = "*deleteallevents \(password ?? "")"
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> DeleteAllEvents {
            set(dictionary: dictionary)
            let ret = DeleteAllEvents(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? "",
                password: value(forKey: .password)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .command, value: "*deleteallevents \(password ?? "")")
            addRequired(key: .userid, value: userid)
            add(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// Executes a command in a chat room to purge all messages for a user
    ///
    /// This does not DELETE the message. It flags the message as moderator removed.
    ///
    /// **Parameters**
    ///
    /// - roomid: (required)
    ///
    /// - userid: (required) the id of the owner of the messages
    ///
    /// - handle: (required) the handle of the owner of the messages
    ///
    /// - password: (required) a valid admin password
    ///
    /// **Warning** This method requires authentication
    ///
    public class PurgeUserMessages: ParametersBase<PurgeUserMessages.Fields, PurgeUserMessages> {
        public enum Fields {
            case roomid
            case userid
            case command
            case password
            case handle
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public var handle: String?
        public var password: String?
        
        private let command: String // "*purge $password $handle"
        
        public init(roomid: String, userid: String, handle: String? = nil, password: String? = nil) {
            self.roomid = roomid
            self.userid = userid
            self.handle = handle
            self.password = password
            self.command = String("*purge \(password!) \(handle!)")
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> PurgeUserMessages {
            set(dictionary: dictionary)
            let ret = PurgeUserMessages(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? "",
                handle: value(forKey: .handle),
                password: value(forKey: .password)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .command, value: String("*purge \(password!) \(handle!)"))
            add(key: .handle, value: handle)
            
            return toDictionary
        }
    }
    
    
    /// Reports a message to the moderation team
    ///
    /// A reported message is temporarily removed from the chat event stream until it is evaluated by a moderator.
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) the id of the room in which you want to report the event
    ///
    /// - eventid: (required) the id of the event that you want to report.
    ///
    /// - userid: (required) user id specific to app
    ///
    /// - reporttype: (required) [defaults="abuse"] e.g. abuse
    ///
    /// **Warning** This method requires authentication.
    ///
    public class ReportMessage: ParametersBase<ReportMessage.Fields, ReportMessage> {
        public enum Fields {
            case roomid
            case eventid
            case userid
            case reporttype
        }
        
        public let roomid: String   // REQUIRED
        public let eventid: String  // REQUIRED
        public let userid: String   // REQUIRED
        public let reporttype: ReportType   // REQUIRED
        
        public init(roomid: String, eventid: String, userid: String, reporttype: ReportType) {
            self.roomid = roomid
            self.eventid = eventid
            self.userid = userid
            self.reporttype = reporttype
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ReportMessage {
            set(dictionary: dictionary)
            let ret = ReportMessage(
                roomid: value(forKey: .roomid) ?? "",
                eventid: value(forKey: .eventid) ?? "",
                userid: value(forKey: .userid) ?? "",
                reporttype: value(forKey: .reporttype) ?? .abuse
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            add(key: .reporttype, value: reporttype.rawValue)
            
            return toDictionary
        }
    }
    
    /// Adds or removes a reaction to an existing event
    ///
    /// After this completes, a new event appears in the stream representing the reaction. The new event will have an updated version of the event in the replyto field, which you can use to update your UI.
    ///
    /// **Parameters**
    ///
    /// - userid: (required) user id specific to app
    ///
    /// - roomid: (required) Room Id, in which you want to react
    ///
    /// - eventid: (required) message id, that you want to report.
    ///
    /// - reacted: (required) true/false
    ///
    /// - reaction: (required) e.g. like
    ///
    /// **Warning** This method requires authentication.
    ///
    public class ReactToEvent: ParametersBase<ReactToEvent.Fields, ReactToEvent> {
        public enum Fields {
            case roomid
            case eventid
            case userid
            case reaction
            case reacted
        }
        
        public let roomid: String   // REQUIRED
        public let eventid: String  // REQUIRED
        public let userid: String   // REQUIRED
        public let reaction: String // REQUIRED
        public let reacted: Bool // REQUIRED
        
        public init(roomid: String, eventid: String, userid: String, reaction: String, reacted: Bool) {
            self.roomid = roomid
            self.eventid = eventid
            self.userid = userid
            self.reaction = reaction
            self.reacted = reacted
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ReactToEvent {
            set(dictionary: dictionary)
            let ret = ReactToEvent(
                roomid: value(forKey: .roomid) ?? "",
                eventid: value(forKey: .eventid) ?? "",
                userid: value(forKey: .userid) ?? "",
                reaction: value(forKey: .reaction) ?? "like",
                reacted: value(forKey: .reacted) ?? false
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            add(key: .reaction, value: reaction)
            add(key: .reacted, value: reacted)
            
            return toDictionary
        }
    }
    
    /// Searches the message history applying the specified filters.
    ///
    /// This returns displayable messages (for example speech, quote, threadedreply) that are in the active state (not flagged by moderator or logically deleted).
    ///
    /// **Parameters**
    ///
    /// - fromuserid: (optional) Return ony events from the specified user
    ///
    /// - fromhandle: (optional) Return only events from a user with the specified handle. Exact match, case insensitive.
    ///
    /// - roomid: (optional) Return only events in the specified room.
    ///
    /// - body: (optional) Returns only messages which contain the specified body substring.
    ///
    /// - limit: (optional) Default is 50, maximum is 200. Limits how many items are returned.
    ///
    /// - cursor: (optional) Leave blank to start from the beginning of the result set; provide the value from the previous returned cursor to resume cursoring through the next page of results.
    ///
    /// - direction: (optional) Defaults to Backward. Pass forward or backward. Backward is newest to oldest order, forward is oldest to newest order.
    ///
    /// - types: (optional) Default = all. Use this to filter for specific event types.
    ///     - speech
    ///     - quote
    ///     - reply
    ///     - announcement
    ///     - custom
    ///     - reaction
    ///     - action
    ///     - enter
    ///     - exit
    ///     - ad
    ///     - roomopened
    ///     - roomclosed
    ///     - purge
    ///     - remove
    ///     - replace
    ///     - bounce
    ///
    public class SearchEvent: ParametersBase<SearchEvent.Fields, SearchEvent> {
        public enum Fields {
            case fromuserid
            case fromhandle
            case roomid
            case body
            case limit
            case cursor
            case direction
            case types
        }
        
        public var fromuserid: String?
        public var fromhandle: String?
        public var roomid: String?
        public var body: String?
        public var limit: Int? = 50
        public var cursor: String?
        public var direction: Ordering?
        public var types: [EventType]?
        
        override public func from(dictionary: [AnyHashable: Any]) -> SearchEvent {
            set(dictionary: dictionary)
            let ret = SearchEvent()
            
            ret.fromuserid = value(forKey: .fromuserid)
            ret.fromhandle = value(forKey: .fromhandle)
            ret.roomid = value(forKey: .roomid)
            ret.body = value(forKey: .body)
            ret.limit = value(forKey: .limit)
            ret.cursor = value(forKey: .cursor)
            ret.direction = value(forKey: .direction)
            ret.types = value(forKey: .types)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .fromuserid, value: fromuserid)
            add(key: .fromhandle, value: fromhandle)
            add(key: .roomid, value: roomid)
            add(key: .body, value: body)
            add(key: .limit, value: limit)
            add(key: .cursor, value: cursor)
            add(key: .direction, value: direction?.rawValue)
            add(key: .types, value: types?.map { $0.rawValue } )

            return toDictionary
        }
    }
    
    /// Reports a user in the room
    ///
    /// - This API enables users to report other users who exhibit abusive behaviors. It enables users to silence another user when a moderator is not present. If the user receives too many reports in a trailing 24 hour period, the user will become flagged at the room level.
    ///
    /// - This API moderates users on the ROOM LEVEL. If a There is an API method that enable reporting users at the global user level which impacts all rooms. This API impacts only the experience for the specified userid within the specified room.
    ///
    /// - This API will return an error (see responses below) if user reporting is not enabled for your application in the application settings by setting User Reports limit to a value > 0.
    ///
    /// - A user who is flagged will have the *shadowban* effect applied.
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) the id of the room in which you want to report the event
    ///
    /// - userid: (required) the application specific user ID of the user reporting the first user
    ///
    /// - reporttype: (required) [defaults="abuse"] Possible values: [.abuse, .spam]. SPAM is unsolicited commercial messages and abuse is hate speach or other unacceptable behavior.
    ///
    /// **RESPONSE CODES**
    ///
    /// 200 | OK : Sweet, sweet success.
    ///
    /// 404 | Not Found : The specified user or application could not be found.
    ///
    /// 412 | PreconditionFailed : The request was rejected because user reporting is not enabled for the application.
    ///
    public class ReportUserInRoom: ParametersBase<ReportUserInRoom.Fields, ReportUserInRoom> {
        public enum Fields {
            case roomid
            case userid
            case reporteduserid
            case reporttype
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public let reporteduserid: String   // REQUIRED
        public let reporttype: ReportType   // REQUIRED
        
        public init(roomid: String, userid: String, reporteduserid: String, reporttype: ReportType) {
            self.roomid = roomid
            self.userid = userid
            self.reporteduserid = reporteduserid
            self.reporttype = reporttype
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ReportUserInRoom {
            set(dictionary: dictionary)
            let ret = ReportUserInRoom(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? "",
                reporteduserid: value(forKey: .reporteduserid) ?? "",
                reporttype: value(forKey: .reporttype) ?? .abuse
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            add(key: .reporttype, value: reporttype.rawValue)
            
            return toDictionary
        }
    }
    
    /// Bounce User
    ///
    /// Remove the user from the room and prevent the user from reentering.
    ///
    /// Optionally display a message to people in the room indicating this person was bounced.
    ///
    /// When you bounce a user from the room, the user is removed from the room and blocked from reentering. Past events generated by that user are not modified (past messages from the user are not removed)
    ///
    /// **Parameters**
    ///
    /// - userid: (required)  user id specific to app
    ///
    /// - bounce: (required) True if the user is being bounced from the room. False if user is debounced, allowing the user to reenter the room.
    ///
    /// - roomid: (required) The ID of the chat room from which to bounce this user
    ///
    /// - announcement: (optional) If provided, this announcement is displayed to the people who are in the room, as the body of a BOUNCE event.
    ///
    public class BounceUser: ParametersBase<BounceUser.Fields, BounceUser> {
        public enum Fields {
            case userid
            case bounce
            case roomid
            case announcement
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public let bounce: Bool     // REQUIRED
        public var announcement: String?
        
        public init(roomid: String, userid: String, bounce: Bool, announcement: String? = nil) {
            self.roomid = roomid
            self.userid = userid
            self.bounce = bounce
            self.announcement = announcement
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> BounceUser {
            set(dictionary: dictionary)
            let ret = BounceUser(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? "",
                bounce: value(forKey: .bounce) ?? false,
                announcement: value(forKey: .announcement)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .bounce, value: bounce)
            add(key: .announcement, value: announcement)

            return toDictionary
        }
    }

    /// Shadow Ban User (In Room Only)
    ///
    /// Will toggle the user's shadow banned flag.
    ///
    /// There is a user level shadow ban (global) and local room level shadow ban.
    ///
    /// A Shadow Banned user can send messages into a chat room, however those messages are flagged as shadow banned. This enables the application to show those messags only to the shadow banned user, so that that person may not know they were shadow banned. This method shadow bans the user on the global level (or you can use this method to lift the ban). You can optionally specify an expiration time. If the expiration time is specified, then each time the shadow banned user tries to send a message the API will check if the shadow ban has expired and will lift the ban.
    ///
    /// **Parameters**
    ///
    /// - userid: (required) The applicaiton provided userid of the user to ban.
    ///
    /// - applyeffect: (required) true or false. If true, user will be set to banned state. If false, will be set to non-banned state.
    ///
    /// - expireseconds: (optional) Duration of shadowban value in seconds. If specified, the shadow ban will be lifted when this time is reached. If not specified, shadowban remains until explicitly lifted. Maximum seconds is a double byte value
    ///
    public class ShadowbanUser: ParametersBase<ShadowbanUser.Fields, ShadowbanUser> {
        public enum Fields {
            case userid
            case roomid
            case applyeffect
            case expireseconds
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public let applyeffect: Bool    // REQUIRED
        public var expireseconds: Double?
        
        public init(roomid: String, userid: String, applyeffect: Bool, expireseconds: Double? = nil) {
            self.roomid = roomid
            self.userid = userid
            self.applyeffect = applyeffect
            self.expireseconds = expireseconds
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> ShadowbanUser {
            set(dictionary: dictionary)
            let ret = ShadowbanUser(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? "",
                applyeffect: value(forKey: .applyeffect) ?? false,
                expireseconds: value(forKey: .expireseconds)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .applyeffect, value: applyeffect)
            add(key: .expireseconds, value: expireseconds)

            return toDictionary
        }
    }
    
    /// Mute User (In Room Only)
    ///
    /// Will toggle the user's shadow banned flag.
    ///
    /// There is a user level shadow ban (global) and local room level shadow ban.
    ///
    /// A Shadow Banned user can send messages into a chat room, however those messages are flagged as shadow banned. This enables the application to show those messags only to the shadow banned user, so that that person may not know they were shadow banned. This method shadow bans the user on the global level (or you can use this method to lift the ban). You can optionally specify an expiration time. If the expiration time is specified, then each time the shadow banned user tries to send a message the API will check if the shadow ban has expired and will lift the ban.
    ///
    /// **Parameters**
    ///
    /// - userid: (required) The applicaiton provided userid of the user to ban.
    ///
    /// - applyeffect: (required) true or false. If true, will have the mute affect applied. If false, mute will not be applied.
    ///
    /// - expireseconds: (optional) Duration of shadowban value in seconds. If specified, the shadow ban will be lifted when this time is reached. If not specified, shadowban remains until explicitly lifted. Maximum seconds is a double byte value
    ///
    public class MuteUser: ParametersBase<MuteUser.Fields, MuteUser> {
        public enum Fields {
            case userid
            case roomid
            case applyeffect
            case expireseconds
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        public let applyeffect: Bool    // REQUIRED
        public var expireseconds: Double?
        
        public init(roomid: String, userid: String, applyeffect: Bool, expireseconds: Double? = nil) {
            self.roomid = roomid
            self.userid = userid
            self.applyeffect = applyeffect
            self.expireseconds = expireseconds
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> MuteUser {
            set(dictionary: dictionary)
            let ret = MuteUser(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? "",
                applyeffect: value(forKey: .applyeffect) ?? false,
                expireseconds: value(forKey: .expireseconds)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .applyeffect, value: applyeffect)
            add(key: .expireseconds, value: expireseconds)

            return toDictionary
        }
    }

    /// Updates the contents of an existing chat event
    ///
    /// This API may be used to update the body of an existing Chat Event. It is used to enable the user to edit the message after it is published. This may only be used with MESSAGE event types (speech, quote, reply). When the chat event is updated another event of type "replace" will be emitted with the updated event contents, and the original event will be replaced in future calls to List Event History, Join and List Previous Events. The event will also be flagged as edited by user.
    ///
    /// **Parameters**
    ///
    /// - roomid: (required) The ID of the chat room conversation
    ///
    /// - eventid: (required) The unique ID of the chat event to be edited. This must be a messsage type event (speech, quote or reply).
    ///
    /// - userid: (required) The application specific user ID updating the chat event. This must be the owner of the comment or moderator / admin.
    ///
    /// - body: (required) The new body contents of the event.
    ///
    /// - customid: (optional) Optionally replace the customid.
    ///
    /// - custompayload: (optional) Optionally replace the payload of the event.
    ///
    /// - customfield1: (optional) Optionally replace the customfield1 value.
    ///
    /// - customfield2: (optional) Optionally replace the customfield2 value.
    ///
    /// - customtags: (optional) Optionaly replace the custom tags.
    ///
    public class UpdateChatEvent: ParametersBase<UpdateChatEvent.Fields, UpdateChatEvent> {
        public enum Fields {
            case roomid
            case eventid
            case userid
            case body
            case customid
            case custompayload
            case customfield1
            case customfield2
            case customtags
        }
        
        public let roomid: String   // REQUIRED
        public let eventid: String  // REQUIRED
        public let userid: String   // REQUIRED
        public let body: String     // REQUIRED
        public var customid: String?
        public var custompayload: String?
        public var customfield1: String?
        public var customfield2: String?
        public var customtags: String?
        
        public init(roomid: String, eventid: String, userid: String, body: String, customid: String? = nil, custompayload: String? = nil, customfield1: String? = nil, customfield2: String? = nil, customtags: String? = nil) {
            self.roomid = roomid
            self.eventid = eventid
            self.userid = userid
            self.body = body
            self.customid = customid
            self.custompayload = custompayload
            self.customfield1 = customfield1
            self.customfield2 = customfield2
            self.customtags = customtags
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> UpdateChatEvent {
            set(dictionary: dictionary)
            let ret = UpdateChatEvent(
                roomid: value(forKey: .roomid) ?? "",
                eventid: value(forKey: .eventid) ?? "",
                userid: value(forKey: .userid) ?? "",
                body: value(forKey: .body) ?? "",
                customid: value(forKey: .customid),
                custompayload: value(forKey: .custompayload),
                customfield1: value(forKey: .customfield1),
                customfield2: value(forKey: .customfield2),
                customtags: value(forKey: .customtags)
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .body, value: body)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)
            add(key: .customfield1, value: customfield1)
            add(key: .customfield2, value: customfield2)
            add(key: .customtags, value: customtags)

            return toDictionary
        }
    }
    
    /// Executes a command in a chat room
    ///
    /// **SENDING A MESSAGE**
    ///
    /// Send any text that doesn't start with a reserved symbol to perform a SAY command.
    ///
    /// *example*
    ///
    /// These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World Hello, World
    ///
    ///  *example*
    ///  These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World
    ///
    ///  **ACTION COMMANDS**
    ///
    ///  - Action commands start with the / character
    ///
    /// *example*
    ///
    /// `/dance nicole`
    /// User sees: `You dance with Nicole`
    /// Nicole sees: `(user's handle) dances with you`
    /// Everyone else sees: `(user's handle) dances with Nicole`
    ///
    /// This requires that the action command dance is on the approved list of commands and Nicole is the handle of a participant in the room, and that actions are allowed in the room.
    ///
    /// **ADMIN COMMANDS**
    ///
    ///  - These commands start with the * character
    ///
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a... enter event: A user has joined the room.
    ///
    /// *example*
    ///
    /// - ban : This bans the user from the entire chat experience (all rooms).
    ///
    /// - restore : This restores the user to the chat experience (all rooms).
    ///
    /// - purge : This deletes all messages from the specified user.
    ///
    /// - deleteallevents : This deletes all messages in this room.
    ///
    public class ExecuteAdminCommand: ParametersBase<ExecuteAdminCommand.Fields, ExecuteAdminCommand> {
        public enum Fields {
            case roomid
            case command
            case userid
            case customtype
            case customid
            case custompayload
        }
        
        public var roomid: String?
        private var command: String? = "*help"
        public var userid: String?
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteAdminCommand {
            set(dictionary: dictionary)
            let ret = ExecuteAdminCommand()
            
            ret.roomid = value(forKey: .roomid)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.customtype = value(forKey: .customtype)
            ret.customid = value(forKey: .customid)
            ret.custompayload = value(forKey: .custompayload)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .customtype, value: customtype)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)
            
            return toDictionary
        }
    }
    
    /// Used to configure the behaviour of the message flow
    ///
    /// **Parameters**
    ///
    /// - limit: (optional) Number of events to return. Default is 100, maximum is 500. Will use default if value set is below default value.
    ///
    /// - eventSpacingMs: (optional) The frequency (in milliseconds) when events are dispatched from buffer. Will use default if value set is below default value.
    ///
    public class StartListeningToChatUpdates: ParametersBase<StartListeningToChatUpdates.Fields, StartListeningToChatUpdates> {
        public enum Fields {
            case limit
            case eventSpacingMs
        }
        
        public var limit: Int = 100 {
            didSet {
                let minAllowed = 100
                if limit < minAllowed {
                    limit = minAllowed
                }
            }
        }
        
        public var eventSpacingMs: Int = 200 {
            didSet {
                let minAllowed = 100
                if eventSpacingMs < minAllowed {
                    eventSpacingMs = minAllowed
                }
            }
        }
    }
    
    /// Users who are not active will automatically exit the room. This method lets the room know that the user is still active so the user doesn't need to rejoin. The SDKs will do this for you automatically.
    ///
    /// You can configure a room to not auto-expire sessions in the settings for that room
    ///
    /// **Parameters**
    ///
    /// - userid: (required) user id specific to app
    ///
    /// - roomid: (required) Room Id, in which you want to react
    ///
    public class KeepAlive: ParametersBase<KeepAlive.Fields, KeepAlive> {
        public enum Fields {
            case roomid
            case userid
        }
        
        public let roomid: String   // REQUIRED
        public let userid: String   // REQUIRED
        
        public init(roomid: String, userid: String) {
            self.roomid = roomid
            self.userid = userid
        }
        
        override public func from(dictionary: [AnyHashable: Any]) -> KeepAlive {
            set(dictionary: dictionary)
            let ret = KeepAlive(
                roomid: value(forKey: .roomid) ?? "",
                userid: value(forKey: .userid) ?? ""
            )
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            addRequired(key: .userid, value: userid)

            return toDictionary
        }
    }
}
