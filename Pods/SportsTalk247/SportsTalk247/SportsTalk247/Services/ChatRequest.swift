import Foundation

public class ChatRequest {
    /// Creates a new chat room
    ///
    /// name: (required) The name of the room
    ///
    /// customid: (optional) A customid for the room. Can be unused, or a unique key.
    ///
    /// description: (optional) The description of the room
    ///
    /// moderation: (required) The type of moderation.
    ///  - ```pre``` - marks the room as Premoderated
    ///  - ```post``` - marks the room as Postmoderated
    ///
    /// enableactions: (optional) [true/false] Turns action commands on or off
    ///
    /// enableenterandexit: (optional) [true/false] Turn enter and exit events on or off. Disable for large rooms to reduce noise.
    ///
    /// enableprofanityfilter: (optional) [default=true / false] Enables profanity filtering.
    ///
    /// delaymessageseconds: (optional) [default=0] Puts a delay on messages from when they are submitted until they show up in the chat. Used for throttling.
    ///
    /// maxreportss: (optiona) Default is 3. This is the maximum amount of user reported flags that can be applied to a message before it is sent to the moderation queue
    ///
    /// - Warning: This method requires authentication.
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
        }
        
        public var name: String?
        public var customid: String?
        public var description: String?
        public var moderation: String?
        public var enableactions: Bool?
        public var enableenterandexit: Bool?
        public var enableprofanityfilter: Bool?
        public var roomisopen: Bool?
        public var maxreports: Int? = 3
        
        
        override public func from(dictionary: [AnyHashable: Any]) -> CreateRoom {
            set(dictionary: dictionary)
            let ret = CreateRoom()
        
            ret.name = value(forKey: .name)
            ret.customid = value(forKey: .customid)
            ret.description = value(forKey: .description)
            ret.enableactions = value(forKey: .enableactions)
            ret.enableenterandexit = value(forKey: .enableenterandexit)
            ret.enableprofanityfilter = value(forKey: .enableprofanityfilter)
            ret.roomisopen = value(forKey: .roomisopen)
            ret.maxreports = value(forKey: .maxreports)
            
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
            add(key: .roomisopen, value: roomisopen)
            add(key: .maxreports, value: maxreports)
            
            return toDictionary
        }
    }
    
    /// Get the details for a room
    ///
    /// roomIdOrSlug: Room Id or Slug of a specific room againts which you want to fetch the details
    ///
    /// - Warning: This method requires authentication.
    public class GetRoomDetails: ParametersBase<GetRoomDetails.Fields, GetRoomDetails> {
        public enum Fields {
            case roomid
        }
        
        public var roomid: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetRoomDetails {
            set(dictionary: dictionary)
            let ret = GetRoomDetails()
            
            ret.roomid = value(forKey: .roomid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            
            return toDictionary
        }
    }
    
    
    /// Deletes the specified room and all events contained therein) by ID
    ///
    /// roomid: that you want to delete
    ///
    /// - Warning: This method requires authentication.
    public class DeleteRoom: ParametersBase<DeleteRoom.Fields, DeleteRoom> {
        public enum Fields {
            case roomid
        }
        
        public var roomid: String?
        public var userid: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> DeleteRoom {
            set(dictionary: dictionary)
            let ret = DeleteRoom()
            ret.roomid = value(forKey: .roomid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .roomid, value: roomid)
            addRequired(key: .roomid, value: roomid)
            
            return toDictionary
        }
    }
    
    /// Updates an existing room
    ///
    /// roomid: (required) The ID of the existing room
    ///
    /// slug: (optional) The URL friendly name of the room
    ///
    /// name: (optional) The name of the room
    ///
    /// description: (optional) The description of the room
    ///
    /// moderation: (optional) [premoderation/postmoderation] Defaults to post-moderation.
    ///
    /// enableactions: (optional) [true/false] Turns action commands on or off
    ///
    /// enableenterandexit: (optional) [true/false] Turn enter and exit events on or off. Disable for large rooms to reduce noise.
    ///
    /// enableprofanityfilter: (optional) [default=true / false] Enables profanity filtering.
    ///
    /// delaymessageseconds: (optional) [default=0] Puts a delay on messages from when they are submitted until they show up in the chat. Used for throttling.
    ///
    /// roomisopen: (optional) [true/false] If false, users cannot perform any commands in the room, chat is suspended.
    ///
    /// throttle: (optional) Defaults to 0. This is the number of seconds to delay new incomming messags so that the chat room doesn't scroll messages too fast.
    ///
    /// userid:  user id specific to App
    ///
    /// - Warning: This method requires authentication.
    public class UpdateRoom: ParametersBase<UpdateRoom.Fields, UpdateRoom> {
        public enum Fields {
            case roomid
            case slug
            case name
            case description
            case customid
            case moderation
            case enableactions
            case enableenterandexit
            case enableprofanityfilter
            case delaymessageseconds
            case roomisopen
            case throttle
            case userid
        }
        
        public var roomid: String?
        public var slug: URL?
        public var name: String?
        public var description: String?
        public var customid: String?
        public var moderation: String?
        public var enableactions: Bool?
        public var enableenterandexit: Bool?
        public var enableprofanityfilter: Bool?
        public var delaymessageseconds: Int?
        public var roomisopen:Bool?
        public var throttle:Int?
        public var userid:String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> UpdateRoom {
            set(dictionary: dictionary)
            let ret = UpdateRoom()
            
            ret.roomid = value(forKey: .roomid)
            ret.slug = value(forKey: .slug)
            ret.name = value(forKey: .name)
            ret.description = value(forKey: .description)
            ret.customid = value(forKey: .customid)
            ret.moderation = value(forKey: .moderation)
            ret.enableactions = value(forKey: .enableactions)
            ret.enableenterandexit = value(forKey: .enableenterandexit)
            ret.enableprofanityfilter = value(forKey: .enableprofanityfilter)
            ret.roomisopen = value(forKey: .roomisopen)
            ret.delaymessageseconds = value(forKey: .delaymessageseconds)
            ret.throttle = value(forKey: .throttle)
            ret.userid = value(forKey: .userid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            add(key: .roomid, value: roomid)
            add(key: .slug, value: slug?.absoluteString)
            add(key: .name, value: name)
            add(key: .description, value: description)
            add(key: .customid, value: customid)
            add(key: .moderation, value: moderation)
            add(key: .enableactions, value: enableactions)
            add(key: .enableenterandexit, value: enableenterandexit)
            add(key: .enableprofanityfilter, value: enableprofanityfilter)
            add(key: .roomisopen, value: roomisopen)
            add(key: .delaymessageseconds, value: delaymessageseconds)
            add(key: .throttle, value: throttle)
            add(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// Update Room (Close a room)
    ///
    /// roomid: (required) The ID of the existing room
    ///
    /// slug: (optional) The URL friendly name of the room
    ///
    /// name: (optional) The name of the room
    ///
    /// description: (optional) The description of the room
    ///
    /// moderation: (optional) [premoderation/postmoderation] Defaults to post-moderation.
    ///
    /// enableactions: (optional) [true/false] Turns action commands on or off
    ///
    /// enableenterandexit: (optional) [true/false] Turn enter and exit events on or off. Disable for large rooms to reduce noise.
    ///
    /// enableprofanityfilter: (optional) [default=true / false] Enables profanity filtering.
    ///
    /// delaymessageseconds: (optional) [default=0] Puts a delay on messages from when they are submitted until they show up in the chat. Used for throttling.
    ///
    /// roomisopen: (optional) [true/false] If false, users cannot perform any commands in the room, chat is suspended.
    ///
    /// userid:  user id specific to App
    ///
    /// - Warning: This method requires authentication.
    public class UpdateRoomCloseARoom: ParametersBase<UpdateRoomCloseARoom.Fields, UpdateRoomCloseARoom> {
        public enum Fields {
            case roomid
            case slug
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
        
        public var roomid: String?
        public var slug: URL?
        public var name: String?
        public var description: String?
        public var moderation: String?
        public var enableactions: Bool?
        public var enableenterandexit: Bool?
        public var enableprofanityfilter: Bool?
        public var delaymessageseconds: Int?
        public var roomisopen:Bool? = false
        public var userid:String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> UpdateRoomCloseARoom {
            set(dictionary: dictionary)
            let ret = UpdateRoomCloseARoom()
            
            ret.roomid = value(forKey: .roomid)
            ret.slug = value(forKey: .slug)
            ret.name = value(forKey: .name)
            ret.description = value(forKey: .description)
            ret.moderation = value(forKey: .moderation)
            ret.enableactions = value(forKey: .enableactions)
            ret.enableenterandexit = value(forKey: .enableenterandexit)
            ret.enableprofanityfilter = value(forKey: .enableprofanityfilter)
            ret.roomisopen = value(forKey: .roomisopen)
            ret.delaymessageseconds = value(forKey: .delaymessageseconds)
            ret.userid = value(forKey: .userid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .roomid, value: roomid)
            add(key: .slug, value: slug?.absoluteString)
            add(key: .name, value: name)
            add(key: .description, value: description)
            add(key: .moderation, value: moderation)
            add(key: .enableactions, value: enableactions)
            add(key: .enableenterandexit, value: enableenterandexit)
            add(key: .enableprofanityfilter, value: enableprofanityfilter)
            add(key: .roomisopen, value: roomisopen)
            add(key: .delaymessageseconds, value: delaymessageseconds)
            add(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// List all the available public chat rooms
    ///
    /// Rooms can be public or private. This method lists all public rooms that everyone can see.
    ///
    /// - Warning: This method requires authentication.
    public class ListRooms {
        public init() { }
        
        public func from(dictionary: [AnyHashable: Any]) -> ListRooms {
            let ret = ListRooms()
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            return [AnyHashable: Any]()
        }
    }
    
    /// Join A Room
    ///
    /// You can join a room either by using the room ID or label. First this method attempts to join a room with the specified ID. If the ID is not found, it attempts to join using the specified label. Labels must be URL friendly. The label is provided when the room is created. For example, if you wanted to label the room with the ID of a match, you can join the room without the need to invoke list rooms to get a room id.
    ///
    /// Logged in users:
    ///  * To log a user in, provide a unique user ID string and chat handle string. If this is the first time the user ID has been used a new user record will be created for the user. Whenever the user creates an event in the room by doing an action like saying something, the user information will be returned.
    ///  * You can optionally also provide a URL to an image and a URL to a profile.
    ///  * If you provide user information and the user already exists in the database, the user will be updated with the new information.
    ///  * The user will be added to the list of participants in the room and the room participant count will increase.
    ///  * The user will be removed from the room automatically after some time if the user doesn't perform any operations.
    ///  * Users can only execute commands in the room if they have joined the room.
    ///  * When a logged in user joins a room an entrance event is generated in the room.
    ///  * When a logged in user leaves a room, an exit event is generated in the room.
    ///
    ///  Arguments:
    ///
    ///  roomid: (required) The room you want to join
    ///
    ///  userid: user id specific to App
    ///
    ///  handle: user handle specific to App
    ///
    ///  displayname: Display Name for user
    ///
    ///  pictureurl:  Picture url of user
    ///
    ///  profileurl: Profile url of user
    ///
    /// - Warning: This method requires authentication.
    public class JoinRoom: ParametersBase<JoinRoom.Fields, JoinRoom> {
        public enum Fields {
            case roomid
            case userid
            case handle
            case displayname
            case pictureurl
            case profileurl
        }
        
        public var roomid: String?
        public var userid: String?
        public var handle: String?
        public var displayname: String?
        public var pictureurl: URL?
        public var profileurl: URL?
        
        override public func from(dictionary: [AnyHashable: Any]) -> JoinRoom {
            set(dictionary: dictionary)
            let ret = JoinRoom()
            
            ret.roomid = value(forKey: .roomid)
            ret.userid = value(forKey: .userid)
            ret.handle = value(forKey: .handle)
            ret.displayname = value(forKey: .displayname)
            ret.pictureurl = value(forKey: .pictureurl)
            ret.profileurl = value(forKey: .profileurl)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            add(key: .userid, value: userid)
            add(key: .handle, value: handle)
            add(key: .displayname, value: displayname)
            add(key: .pictureurl, value: pictureurl?.absoluteString)
            add(key: .profileurl, value: profileurl?.absoluteString)
            
            return toDictionary
        }
    }
    
    /// Join A Room (By Custom Id)
    ///
    /// This method is the same as Join Room, except you can use your customid
    ///
    /// The benefit of this method is you don't need to query to get the roomid using customid, and then make another call to join the room. This eliminates a request and enables you to bring your chat experience to your user faster.
    ///
    /// Logged in users:
    ///  * To log a user in, provide a unique user ID string and chat handle string. If this is the first time the user ID has been used a new user record will be created for the user. Whenever the user creates an event in the room by doing an action like saying something, the user information will be returned.
    ///  * You can optionally also provide a URL to an image and a URL to a profile.
    ///  * If you provide user information and the user already exists in the database, the user will be updated with the new information.
    ///  * The user will be added to the list of participants in the room and the room participant count will increase.
    ///  * The user will be removed from the room automatically after some time if the user doesn't perform any operations.
    ///  * Users can only execute commands in the room if they have joined the room.
    ///  * When a logged in user joins a room an entrance event is generated in the room.
    ///  * When a logged in user leaves a room, an exit event is generated in the room.
    ///
    ///  Arguments:
    ///
    ///  customid: your custom id
    ///
    ///  userid: user id specific to App
    ///
    ///  handle: user handle specific to App
    ///
    ///  displayname: Display Name for user
    ///
    ///  pictureurl:  Picture url of user
    ///
    ///  profileurl: Profile url of user
    ///
    /// - Warning: This method requires authentication.
    public class JoinRoomByCustomId: ParametersBase<JoinRoomByCustomId.Fields, JoinRoomByCustomId> {
       public enum Fields {
           case customid
           case userid
           case handle
           case displayname
           case pictureurl
           case profileurl
       }
       
       public var customid: String?
       public var userid: String?
       public var handle: String?
       public var displayname: String?
       public var pictureurl: URL?
       public var profileurl: URL?
       
       override public func from(dictionary: [AnyHashable: Any]) -> JoinRoomByCustomId {
           set(dictionary: dictionary)
           let ret = JoinRoomByCustomId()
           
           ret.customid = value(forKey: .customid)
           ret.userid = value(forKey: .userid)
           ret.handle = value(forKey: .handle)
           ret.displayname = value(forKey: .displayname)
           ret.pictureurl = value(forKey: .pictureurl)
           ret.profileurl = value(forKey: .profileurl)
           
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
           
           return toDictionary
       }
    }

    
    /// List all the participants in the specified room
    ///
    /// Use this method to cursor through the people who have subscribe to the room.
    ///
    /// To cursor through the results if there are many participants, invoke this function many times. Each result will return a cursor value and you can pass that value to the next invokation to get the next page of results. The result set will also include a next field with the full URL to get the next page, so you can just keep reading that and requesting that URL until you reach the end. When you reach the end, no more results will be returned or the result set will be less than maxresults and the next field will be empty.
    ///
    ///  Arguments:
    ///
    ///  roomid:  room id that you want to list the participants
    ///
    ///  cursor:  you can pass that value to the next invokation to get the next page of results
    ///
    ///  limit: default is 200
    ///
    /// - Warning: This method requires authentication.
    public class ListRoomParticipants: ParametersBase<ListRoomParticipants.Fields, ListRoomParticipants> {
        public enum Fields {
            case roomid
            case cursor
            case limit
        }
        
        public var roomid: String?
        public var cursor: String? = ""
        public var limit: Int? = 200
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListRoomParticipants {
            set(dictionary: dictionary)
            let ret = ListRoomParticipants()
            ret.roomid = value(forKey: .roomid)
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }

    /// List Event History
    ///
    /// - This method enables you to download all of the events from a room in large batches. It should only be used if doing a data export.
    ///
    /// - This method returns a list of events sorted from oldest to newest.
    ///
    /// - This method returns all events, even those in the inactive state
    ///
    ///  Arguments:
    ///
    ///  cursor: (Optional) If not provided, the most recent events will be returned. To get older events, call this method again using the cursor string returned from the previous call.
    ///
    ///  limit: (Optional) default is 100, maximum 2000
    public class ListEventHistory: ParametersBase<ListEventHistory.Fields, ListEventHistory> {
        public enum Fields {
            case roomid
            case cursor
            case limit
        }
        
        public var roomid: String?
        public var cursor: String? = ""
        public var limit: Int? = 100
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListEventHistory {
            set(dictionary: dictionary)
            let ret = ListEventHistory()
            ret.roomid = value(forKey: .roomid)
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }

    /// List Previous Events
    ///
    /// - This method allows you to go back in time to "scroll" in reverse through past messages. The typical use case for this method is to power the scroll-back feature of a chat window allowing the user to look at recent messages that have scrolled out of view. It's intended use is to retrieve small batches of historical events as the user is scrolling up.
    ///
    /// - This method returns a list of events sorted from newest to oldest.
    ///
    /// - This method excludes events that are not in the active state (for example if they are removed by a moderator)
    ///
    /// - This method excludes non-displayable events (reaction, replace, remove, purge)
    ///
    /// - This method will not return events that were emitted and then deleted before this method was called
    ///
    ///  Arguments:
    ///
    ///  cursor: (Optional) If not provided, the most recent events will be returned. To get older events, call this method again using the cursor string returned from the previous call.
    ///
    ///  limit: (Optional) default is 100, maximum 500
    
    public class ListPreviousEvents: ParametersBase<ListPreviousEvents.Fields, ListPreviousEvents> {
        public enum Fields {
            case roomid
            case cursor
            case limit
        }
        
        public var roomid: String?
        public var cursor: String? = ""
        public var limit: Int? = 100
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListPreviousEvents {
            set(dictionary: dictionary)
            let ret = ListPreviousEvents()
            ret.roomid = value(forKey: .roomid)
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            
            return toDictionary
        }
    }

    
    /// Exit a Room
    ///
    ///  Arguments:
    ///
    ///  roomid:  Room id that you want to exit
    ///
    ///  userid:  user id specific to App
    ///
    /// - Warning: This method requires authentication.
    public class ExitRoom: ParametersBase<ExitRoom.Fields, ExitRoom> {
        public enum Fields {
            case roomid
            case userid
        }
        
        public var roomid: String?
        public var userid: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExitRoom {
            set(dictionary: dictionary)
            let ret = ExitRoom()
            
            ret.roomid = value(forKey: .roomid)
            ret.userid = value(forKey: .userid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            add(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    
    /// Get the Recent Updates to a Room
    ///
    /// You can use this function to poll the room to get the recent events in the room. The recommended poll interval is 500ms. Each event has an ID and a timestamp. To detect new messages using polling, call this function and then process items with a newer timestamp than the most recent one you have already processed.
    ///
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a... enter event: A user has joined the room.
    ///
    /// exit event: A user has exited chat. message: A user has communicated a message. reply: A user sent a message in response to another user. reaction: A user has reacted to a message posted by another user. action: A user is performing an ACTION (emote) alone or with another user.
    ///
    ///  Enter and Exit Events:
    ///
    ///  Enter and Exit events may not be sent if the room is expected to have a very large number of users.
    ///
    ///  Arguments:
    ///
    ///  roomid:  Room id that you want to update
    ///
    ///  cursor:  Used in cursoring through the list. Gets the next batch of users. Read 'nextCur' property of result set and pass as cursor value.
    ///
    /// - Warning: This method requires authentication.
    public class GetUpdates: ParametersBase<GetUpdates.Fields, GetUpdates> {
        public enum Fields {
            case roomid
            case cursor
        }
        
        public var roomid: String?
        public var cursor: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> GetUpdates {
            set(dictionary: dictionary)
            let ret = GetUpdates()
            
            ret.roomid = value(forKey: .roomid)
            ret.cursor = value(forKey: .cursor)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            add(key: .cursor, value: cursor)
            
            return toDictionary
        }
    }
    
    /// Executes a command in a chat room
    ///
    /// SENDING A MESSAGE:
    ///
    ///  * Send any text that doesn't start with a reserved symbol to perform a SAY command.
    ///  * Use this API call to REPLY to existing messages
    ///  * Use this API call to perform ACTION commands
    ///  * Use this API call to perform ADMIN commands
    ///
    ///  example:
    ///  These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World Hello, World
    ///
    ///  ACTION COMMANDS:
    ///
    ///  * Action commands start with the / character
    ///
    /// example:
    ///
    /// /dance nicole User sees:
    /// You dance with Nicole
    /// Nicole sees: (user's handle) dances with you
    /// Everyone else sees: (user's handle) dances with Nicoel
    ///
    /// This requires that the action command dance is on the approved list of commands and Nicole is the handle of a participant in the room, and that actions are allowed in the room.
    ///
    /// ADMIN COMMANDS:
    ///
    ///  * These commands start with the * character
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a... enter event: A user has joined the room.
    ///
    /// example:
    ///
    ///  * ban : This bans the user from the entire chat experience (all rooms).
    ///  * restore : This restores the user to the chat experience (all rooms).
    ///  * purge : This deletes all messages from the specified user.
    ///  * deleteallevents : This deletes all messages in this room.
    ///
    ///  SENDING A REPLY::
    ///
    ///   * replyto:  Use this field to provide the EventID of an event you want to reply to. Replies have a different event type and contain a copy of the original event.
    ///
    ///  Arguments:
    ///
    ///  command:  command that you want to pass
    ///
    ///  userid: user id specific to App
    ///
    ///  customtype: any type you want to save
    ///
    ///  customid: any custom id you want to pass
    ///
    ///  custompayload: any payload.
    ///
    /// - Warning: This method requires authentication.
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
        
        public var roomid: String?
        public var command: String?
        public var userid: String?
        public var moderation: String?
        public var eventtype: EventType?
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteChatCommand {
            set(dictionary: dictionary)
            let ret = ExecuteChatCommand()
            
            ret.roomid = value(forKey: .roomid)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.moderation = value(forKey: .moderation)
            ret.eventtype = value(forKey: .eventtype)
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
    /// SENDING A MESSAGE:
    ///
    ///  * Send any text that doesn't start with a reserved symbol to perform a SAY command.
    ///  * Use this API call to REPLY to existing messages
    ///  * Use this API call to perform ACTION commands
    ///  * Use this API call to perform ADMIN commands
    ///
    ///  example:
    ///  These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World Hello, World
    ///
    ///  ACTION COMMANDS:
    ///
    ///  * Action commands start with the / character
    ///
    /// example:
    ///
    /// /dance nicole User sees:
    /// You dance with Nicole
    /// Nicole sees: (user's handle) dances with you
    /// Everyone else sees: (user's handle) dances with Nicoel
    ///
    /// This requires that the action command dance is on the approved list of commands and Nicole is the handle of a participant in the room, and that actions are allowed in the room.
    ///
    /// ADMIN COMMANDS:
    ///
    ///  * These commands start with the * character
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a... enter event: A user has joined the room.
    ///
    /// example:
    ///
    ///  * ban : This bans the user from the entire chat experience (all rooms).
    ///  * restore : This restores the user to the chat experience (all rooms).
    ///  * purge : This deletes all messages from the specified user.
    ///  * deleteallevents : This deletes all messages in this room.
    ///
    ///  SENDING A REPLY::
    ///
    ///   * replyto:  Use this field to provide the EventID of an event you want to reply to. Replies have a different event type and contain a copy of the original event.
    ///
    ///  Arguments:
    ///
    ///  command:  command that you want to pass
    ///
    ///  userid: user id specific to App
    ///
    ///  customtype: any type you want to save
    ///
    ///  customid: any custom id you want to pass
    ///
    ///  custompayload: any payload.
    ///
    /// - Warning: This method requires authentication.
    public class ExecuteDanceAction: ParametersBase<ExecuteDanceAction.Fields, ExecuteDanceAction> {
        public enum Fields {
            case roomid
            case command
            case userid
            case customtype
            case customid
            case custompayload
        }
        
        public var roomid: String?
        public var command: String?
        public var userid: String?
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteDanceAction {
            set(dictionary: dictionary)
            let ret = ExecuteDanceAction()
            
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
    
    /// Executes a command in a chat room
    ///
    /// SENDING A MESSAGE:
    ///
    ///  * Send any text that doesn't start with a reserved symbol to perform a SAY command.
    ///  * Use this API call to REPLY to existing messages
    ///
    ///  example:
    ///  These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World Hello, World
    ///
    ///  ACTION COMMANDS:
    ///
    ///  * Action commands start with the / character
    ///
    /// example:
    ///
    /// /dance nicole User sees:
    /// You dance with Nicole
    /// Nicole sees: (user's handle) dances with you
    /// Everyone else sees: (user's handle) dances with Nicoel
    ///
    /// This requires that the action command dance is on the approved list of commands and Nicole is the handle of a participant in the room, and that actions are allowed in the room.
    ///
    /// ADMIN COMMANDS:
    ///
    ///  * These commands start with the * character
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a... enter event: A user has joined the room.
    ///
    /// example:
    ///
    ///  * ban : This bans the user from the entire chat experience (all rooms).
    ///  * restore : This restores the user to the chat experience (all rooms).
    ///  * purge : This deletes all messages from the specified user.
    ///  * deleteallevents : This deletes all messages in this room.
    ///
    ///  SENDING A REPLY::
    ///
    ///   * replyto:  Use this field to provide the EventID of an event you want to reply to. Replies have a different event type and contain a copy of the original event.
    ///
    ///  Arguments:
    ///
    ///  command:  command that you want to pass
    ///
    ///  userid: user id specific to App
    ///
    ///  customtype: any type you want to save
    ///
    ///  customid: any custom id you want to pass
    ///
    ///  custompayload: any payload.
    ///
    /// - Warning: This method requires authentication.
    public class SendQuotedReply: ParametersBase<SendQuotedReply.Fields, SendQuotedReply> {
        public enum Fields {
            case roomid
            case command
            case userid
            case replyto
        }
        
        public var roomid: String?
        public var command: String?
        public var userid: String?
        public var replyto: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> SendQuotedReply {
            set(dictionary: dictionary)
            let ret = SendQuotedReply()
            
            ret.roomid = value(forKey: .roomid)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.replyto = value(forKey: .replyto)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .replyto, value: replyto)
            
            return toDictionary
        }
    }
    
    /// Executes a command in a chat room
    ///
    /// SENDING A MESSAGE:
    ///
    ///  * Send any text that doesn't start with a reserved symbol to perform a SAY command.
    ///  * Use this API call to REPLY to existing messages
    ///
    ///  example:
    ///  These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World Hello, World
    ///
    ///  ACTION COMMANDS:
    ///
    ///  * Action commands start with the / character
    ///
    /// example:
    ///
    /// /dance nicole User sees:
    /// You dance with Nicole
    /// Nicole sees: (user's handle) dances with you
    /// Everyone else sees: (user's handle) dances with Nicoel
    ///
    /// This requires that the action command dance is on the approved list of commands and Nicole is the handle of a participant in the room, and that actions are allowed in the room.
    ///
    /// ADMIN COMMANDS:
    ///
    ///  * These commands start with the * character
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a... enter event: A user has joined the room.
    ///
    /// example:
    ///
    ///  * ban : This bans the user from the entire chat experience (all rooms).
    ///  * restore : This restores the user to the chat experience (all rooms).
    ///  * purge : This deletes all messages from the specified user.
    ///  * deleteallevents : This deletes all messages in this room.
    ///
    ///  SENDING A REPLY::
    ///
    ///   * replyto:  Use this field to provide the EventID of an event you want to reply to. Replies have a different event type and contain a copy of the original event.
    ///
    ///  Arguments:
    ///
    ///  command:  command that you want to pass
    ///
    ///  userid: user id specific to App
    ///
    ///  customtype: any type you want to save
    ///
    ///  customid: any custom id you want to pass
    ///
    ///  custompayload: any payload.
    ///
    /// - Warning: This method requires authentication.
    public class SendThreadedReply: ParametersBase<SendThreadedReply.Fields, SendThreadedReply> {
        public enum Fields {
            case roomid
            case command
            case userid
            case replyto
        }
        
        public var roomid: String?
        public var command: String?
        public var userid: String?
        public var replyto: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> SendThreadedReply {
            set(dictionary: dictionary)
            let ret = SendThreadedReply()
            
            ret.roomid = value(forKey: .roomid)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.replyto = value(forKey: .replyto)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .replyto, value: replyto)
            
            return toDictionary
        }
    }
    
    /// Gets a list of users messages
    ///
    /// The purpose of this method is to get a list of messages or comments by a user, with count of replies and reaction data. This way, you can easily make a screen in your application that shows the user a list of their comment contributions and how people reacted to it.
    ///
    ///  Arguments:
    ///
    ///  roomid:  Room id, in which you want to fetch messages
    ///
    ///  userid:  user id, against which you want to fetch messages
    ///
    ///  cursor:  Used in cursoring through the list. Gets the next batch of users. Read 'nextCur' property of result set and pass as cursor value.
    ///
    ///  limit: default 200
    ///
    /// - Warning: This method requires authentication.
    public class ListMessagesByUser: ParametersBase<ListMessagesByUser.Fields, ListMessagesByUser> {
        public enum Fields {
            case cursor
            case limit
            case userid
            case roomid
        }
        
        public var cursor: String?
        public var limit: String? = defaultLimit
        public var userId: String?
        public var roomid: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ListMessagesByUser {
            set(dictionary: dictionary)
            let ret = ListMessagesByUser()
            
            ret.cursor = value(forKey: .cursor)
            ret.limit = value(forKey: .limit)
            ret.userId = value(forKey: .userid)
            ret.roomid = value(forKey: .roomid)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .cursor, value: cursor)
            add(key: .limit, value: limit)
            add(key: .roomid, value: roomid)
            addRequired(key: .userid, value: userId)
            
            return toDictionary
        }
    }
    
    /// Set deleted (LOGICAL DELETE)
    ///
    /// Everything in a chat room is an event. Each event has a type. Events of type "speech, reply, quote" are considered "messages".
    ///
    /// Use logical delete if you want to flag something as deleted without actually deleting the message so you still have the data. When you use this method:
    ///
    /// The message is not actually deleted. The comment is flagged as deleted, and can no longer be read, but replies are not deleted.
    /// If flag "permanentifnoreplies" is true, then it will be a permanent delete instead of logical delete for this comment if it has no children.
    /// If you use "permanentifnoreplies" = true, and this comment has a parent that has been logically deleted, and this is the only child, then the parent will also be permanently deleted (and so on up the hierarchy of events).
    ///
    /// Arguments:
    ///
    /// roomid: (required) The ID of the room containing the event
    ///
    /// eventid: (required) The unique ID of the chat event to delete. The user posting the delete request must be the owner of the event or have moderator permission
    ///
    /// userId: (required) This is the application specific user ID of the user deleting the comment. Must be the owner of the message event or authorized moderator.
    ///
    /// deleted: (required) Set to true or false to flag the comment as deleted. If a comment is deleted, then it will have the deleted field set to true, in which case the contents of the event message should not be shown and the body of the message will not be returned by the API by default. If a previously deleted message is undeleted, the flag for deleted is set to false and the original comment body is returned
    ///
    /// permanentifnoreplies: (optional) If this optional parameter is set to "true", then if this event has no replies it will be permanently deleted instead of logically deleted. If a permanent delete is performed, the result will include the field "permanentdelete=true"
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
        
        public var roomid: String!
        public var eventid: String!
        public var userid: String!
        public var deleted: Bool!
        public var permanentifnoreplies: Bool?
        
        override public func from(dictionary: [AnyHashable: Any]) -> FlagEventLogicallyDeleted {
            set(dictionary: dictionary)
            let ret = FlagEventLogicallyDeleted()
            
            ret.roomid = value(forKey: .roomid)
            ret.eventid = value(forKey: .eventid)
            ret.userid = value(forKey: .userid)
            ret.deleted = value(forKey: .deleted)
            ret.permanentifnoreplies = value(forKey: .permanentifnoreplies)
            
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
    
    /// Removes a message from a room.
    ///
    /// This does not DELETE the message. It flags the message as moderator removed.
    ///
    /// Arguments:
    ///
    /// roomId:  the room id in which you want to remove the message
    ///
    /// eventId:  the message you want to remove
    ///
    /// userId: (Optional)  the id to whom the message belongs to
    /// If provided, a check will be made to enforce this userid (the one deleting the event) is the owner of the event or has elevated permissions. If null, it assumes your business service made the determination to delete the event.
    ///
    /// permanent: (Optional) remove permanently if no reply. Defaults to true
    ///
    /// - Warning: This method requires authentication.
    public class DeleteEvent: ParametersBase<DeleteEvent.Fields, DeleteEvent> {
        public enum Fields {
            case roomid
            case eventid
            case userid
        }
        
        public var roomid: String!
        public var eventid: String!
        public var userid: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> DeleteEvent {
            set(dictionary: dictionary)
            let ret = DeleteEvent()
            
            ret.roomid = value(forKey: .roomid)
            ret.eventid = value(forKey: .eventid)
            ret.userid = value(forKey: .userid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            add(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// Removes all messages in a room.
    ///
    ///  Arguments:
    ///
    ///  password: a valid admin password
    ///
    public class DeleteAllEvents: ParametersBase<DeleteAllEvents.Fields, DeleteAllEvents> {
        public enum Fields {
            case roomid
            case command
            case userid
            case password
        }
        
        public var roomid: String!
        private var command: String!
        public var password: String!
        public var userid: String!
        
        override public func from(dictionary: [AnyHashable: Any]) -> DeleteAllEvents {
            set(dictionary: dictionary)
            let ret = DeleteAllEvents()
            
            ret.roomid = value(forKey: .roomid)
            ret.command = value(forKey: .command)
            ret.password = value(forKey: .password)
            ret.userid = value(forKey: .userid)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .command, value: "*deleteallevents" + " " + password)
            addRequired(key: .userid, value: userid)
            
            return toDictionary
        }
    }
    
    /// Executes a command in a chat room to purge all messages for a user
    ///
    /// This does not DELETE the message. It flags the message as moderator removed.
    ///
    ///  Arguments:
    ///
    ///  handle: the handle of the owner of the messages
    ///
    ///  password: a valid admin password
    ///
    /// - Warning: This method requires authentication.
    public class PurgeUserMessages: ParametersBase<PurgeUserMessages.Fields, PurgeUserMessages> {
        public enum Fields {
            case roomid
            case userid
            case command
            case password
            case handle
        }
        
        public var roomid: String!
        public var userid: String!
        public var handle: String!
        public var password: String!
        private var command: String!
        
        override public func from(dictionary: [AnyHashable: Any]) -> PurgeUserMessages {
            set(dictionary: dictionary)
            let ret = PurgeUserMessages()
            
            ret.roomid = value(forKey: .roomid)
            ret.userid = value(forKey: .userid)
            ret.handle = value(forKey: .handle)
            ret.password = value(forKey: .password)
            ret.command = value(forKey: .command)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .command, value: String("*purge \(password!) \(handle!)"))
            
            return toDictionary
        }
    }
    
    
    /// REPORTS a message to the moderation team
    ///
    /// A reported message is temporarily removed from the chat event stream until it is evaluated by a moderator.
    ///
    ///  Arguments:
    ///
    ///  reporttype:  e.g. abuse
    ///
    ///  userid:  user id specific to app
    ///
    ///  chatRoomId: Room Id, in which you want to report the message
    ///
    ///  chatMessageId: message id, that you want to report.
    ///
    /// - Warning: This method requires authentication.
    public class ReportMessage: ParametersBase<ReportMessage.Fields, ReportMessage> {
        public enum Fields {
            case chatRoomId
            case chatMessageId
            case chat_room_newest_speech_id
            case userid
            case reporttype
        }
        
        public var chatRoomId: String?
        public var chatMessageId: String?
        public var chat_room_newest_speech_id: String?
        public var userid: String?
        public var reporttype = "abuse"
        
        override public func from(dictionary: [AnyHashable: Any]) -> ReportMessage {
            set(dictionary: dictionary)
            let ret = ReportMessage()
            
            ret.chatRoomId = value(forKey: .chatRoomId)
            ret.chatMessageId = value(forKey: .chatMessageId)
            ret.chat_room_newest_speech_id = value(forKey: .chat_room_newest_speech_id)
            ret.userid = value(forKey: .userid)
            ret.reporttype = value(forKey: .reporttype) ?? "abuse"
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .reporttype, value: reporttype)
            
            return toDictionary
        }
    }
    
    
    /// React To Event
    ///
    /// Adds or removes a reaction to an existing event
    ///
    /// After this completes, a new event appears in the stream representing the reaction. The new event will have an updated version of the event in the replyto field, which you can use to update your UI.
    ///
    ///  Arguments:
    ///
    ///  userid:  user id specific to app
    ///
    ///  roomId: Room Id, in which you want to react
    ///
    ///  roomNewestEventId: message id, that you want to report.
    ///
    ///  reacted: true/false
    ///
    ///  reaction: e.g. like
    ///
    /// - Warning: This method requires authentication.
    public class ReactToEvent: ParametersBase<ReactToEvent.Fields, ReactToEvent> {
        public enum Fields {
            case roomid
            case eventid
            case userid
            case reaction
            case reacted
        }
        
        public var roomid: String?
        public var eventid: String?
        public var userid: String?
        public var reaction: String?
        public var reacted: String? = "true"
        
        override public func from(dictionary: [AnyHashable: Any]) -> ReactToEvent {
            set(dictionary: dictionary)
            let ret = ReactToEvent()
            
            ret.roomid = value(forKey: .roomid)
            ret.eventid = value(forKey: .eventid)
            ret.userid = value(forKey: .userid)
            ret.reaction = value(forKey: .reaction)
            ret.reacted = value(forKey: .reacted)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomid, value: roomid)
            addRequired(key: .eventid, value: eventid)
            add(key: .userid, value: userid)
            add(key: .reaction, value: reaction)
            add(key: .reacted, value: reacted)
            
            return toDictionary
        }
    }
    
    /// Bounce User
    ///
    /// Remove the user from the room and prevent the user from reentering.
    ///
    /// Optionally display a message to people in the room indicating this person was bounced.
    /// When you bounce a user from the room, the user is removed from the room and blocked from reentering.
    /// Past events generated by that user are not modified (past messages from the user are not removed)
    ///
    ///  Arguments:
    ///
    ///  userid: (required)  user id specific to app
    ///
    ///  bounce: (required) True if the user is being bounced from the room. False if user is debounced, allowing the user to reenter the room.
    ///
    ///  roomid: (required) The ID of the chat room from which to bounce this user
    ///
    ///  announcement: (optional) If provided, this announcement is displayed to the people who are in the room, as the body of a BOUNCE event.
    ///
    public class BounceUser: ParametersBase<BounceUser.Fields, BounceUser> {
        public enum Fields {
            case userid
            case bounce
            case roomid
            case announcement
        }
        
        public var userid: String?
        public var bounce: Bool?
        public var roomid: String?
        public var announcement: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> BounceUser {
            set(dictionary: dictionary)
            let ret = BounceUser()
            
            ret.userid = value(forKey: .userid)
            ret.bounce = value(forKey: .bounce)
            ret.roomid = value(forKey: .roomid)
            ret.announcement = value(forKey: .announcement)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .userid, value: userid)
            addRequired(key: .bounce, value: bounce)
            addRequired(key: .roomid, value: roomid)
            add(key: .announcement, value: announcement)

            return toDictionary
        }
    }
    
    ///  Execute Admin Command (*help)
    ///
    /// SENDING A MESSAGE:
    ///
    ///  * Send any text that doesn't start with a reserved symbol to perform a SAY command.
    ///  * Use this API call to REPLY to existing messages
    ///
    ///  example:
    ///  These commands both do the same thing, which is send the message "Hello World" to the room. SAY Hello, World Hello, World
    ///
    ///  ACTION COMMANDS:
    ///
    ///  * Action commands start with the / character
    ///
    /// example:
    ///
    /// /dance nicole User sees:
    /// You dance with Nicole
    /// Nicole sees: (user's handle) dances with you
    /// Everyone else sees: (user's handle) dances with Nicoel
    ///
    /// This requires that the action command dance is on the approved list of commands and Nicole is the handle of a participant in the room, and that actions are allowed in the room.
    ///
    /// ADMIN COMMANDS:
    ///
    ///  * These commands start with the * character
    /// Each event in the stream has a KIND property. Inspect the property to determine if it is a... enter event: A user has joined the room.
    ///
    /// example:
    ///
    ///  * *banuserhere nicole: This bans the user Nicole from this room.
    ///  * *banusereverywhere nicole: This bans user Nicole from all rooms.
    ///  * *deletemessageshere nicole: This deletes all messages by user Nicole in this room
    ///  * *deletemessageseverywhere nicole: This deletes all messages by user Nicole in all rooms
    ///
    ///  Arguments:
    ///
    ///  command:  command that you want to pass
    ///
    ///  userid: user id specific to App
    ///
    ///  customtype: any type you want to save
    ///
    ///  customid: any custom id you want to pass
    ///
    ///  custompayload: any payload.
    ///
    /// - Warning: This method requires authentication.
    public class ExecuteAdminCommand: ParametersBase<ExecuteAdminCommand.Fields, ExecuteAdminCommand> {
        public enum Fields {
            case roomId
            case command
            case userid
            case customtype
            case customid
            case custompayload
        }
        
        public var roomId: String?
        public var command: String?
        public var userid: String?
        public var customtype: String?
        public var customid: String?
        public var custompayload: String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> ExecuteAdminCommand {
            set(dictionary: dictionary)
            let ret = ExecuteAdminCommand()
            
            ret.roomId = value(forKey: .roomId)
            ret.command = value(forKey: .command)
            ret.userid = value(forKey: .userid)
            ret.customtype = value(forKey: .customtype)
            ret.customid = value(forKey: .customid)
            ret.custompayload = value(forKey: .custompayload)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .roomId, value: roomId)
            add(key: .command, value: command)
            add(key: .userid, value: userid)
            add(key: .customtype, value: customtype)
            add(key: .customid, value: customid)
            add(key: .custompayload, value: custompayload)
            
            return toDictionary
        }
    }
}

// MARK: - Event Subscription
extension ChatRequest {
    public class StartEventUpdates: ParametersBase<StartEventUpdates.Fields, StartEventUpdates> {
        public enum Fields {
            case roomId
        }
        
        public var roomId: String?

        override public func from(dictionary: [AnyHashable: Any]) -> StartEventUpdates {
            set(dictionary: dictionary)
            let ret = StartEventUpdates()
            ret.roomId = value(forKey: .roomId)
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            addRequired(key: .roomId, value: roomId)
            return toDictionary
        }
    }
}
