import UIKit
import SportsTalk_iOS_SDK

protocol ChatLogView
{
    func refresh(_ firstTimeMakeUserToBottom: Bool)
    func startLoader()
    func stopLoader()
    func insertRowsAtIndexes(indexpaths: [IndexPath])
    
    func refreshRowAt(indexpath: IndexPath)
    
    var isCollectionViewLoading: Bool { set get }
}

class ChatLogViewPresenter
{
    private var view: ChatLogView!
    private var services: Services!
    
    var users = [User]()
    var joinedRoom: Room?
    var messages = [Message]()
    var reactions = [Message]()
    var lastEventId = ""
    
    private var internalTimer: Timer?
    private var pollingStarted = false
    {
        didSet
        {
            if pollingStarted
            {
                DispatchQueue.main.async
                {
                    guard self.internalTimer == nil else { return }
                    self.internalTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.checkUpdates), userInfo: nil, repeats: true)
                }
            }
            else
            {
                guard internalTimer != nil else { return }
                internalTimer?.invalidate()
                internalTimer = nil
            }
        }
    }
    
    @objc func checkUpdates()
    {
        getUpdates(second: true)
//        self.getUpdatesMore()
    }
    
    func gettingDismissed()
    {
        pollingStarted = false
    }
    
    init(view: ChatLogView, services: Services)
    {
        self.view = view
        self.services = services
    }
    
    func loadData()
    {
        guard let selectedUser = selectedUser else { return }
        
        self.joinRoomWithUser(user: selectedUser)
    }
        
    func joinRoomWithUser(user: User)
    {
        let request = ChatRoomsServices.JoinRoomAuthenticatedUser()
        request.roomid = roomId
        request.userid = user.userid
        
        view.startLoader()
        
        services.ams.chatRoomsServices(request) { (response) in
            if let response = response["data"] as? [String: Any]
            {
                self.view.stopLoader()
                
                if let roomResponse = response["room"] as? [String: Any]
                {
                    self.joinedRoom = Room().convertIntoModel(response: roomResponse)
                    
                    self.getUpdates()
                    self.pollingStarted = true
                }
            }
        }
    }
    
    func getUpdates(second:Bool = false)
    {
        let request = ChatRoomsServices.GetUpdates()
        request.roomId = roomId
                
        if !second
        {
            view.startLoader()
        }
        
        services.ams.chatRoomsServices(request) { (response) in
            if let responseMessages = response["data"] as? [[String: Any]]
            {
                DispatchQueue.main.async
                    {
                        self.messages = [Message]()
                        self.reactions = [Message]()
                        self.view.stopLoader()
                        
                        for responseMessage in responseMessages
                        {
                            let message = Message().convertIntoModel(response: responseMessage)
                            
                            self.lastEventId = message.id ?? ""
                            
                            if message.eventtype == "speech"
                            {
                                self.messages.append(message)
                            }
                            else if message.eventtype == "reaction"
                            {
                                self.reactions.append(message)
                            }
                        }
                        
                        if second
                        {
                            self.view.refresh(false)
                        }
                        else
                        {
                            self.view.refresh(true)
                        }
                }
            }
        }
    }
    
    func getUpdatesMore()
    {
        let request = ChatRoomsServices.GetUpdatesMore()
        request.roomIdOrLabel = roomId
        request.eventid = self.lastEventId
        
        services.ams.chatRoomsServices(request) { (response) in
            if let responseMessages = response["data"] as? [[String: Any]]
            {
                var indexPaths = [IndexPath]()
                var countToStartWith = self.messages.count
                
                for responseMessage in responseMessages
                {
                    let message = Message().convertIntoModel(response: responseMessage)
                    
                    self.lastEventId = message.id ?? ""
                    
                    if message.eventtype == "speech"
                    {
                        self.messages.append(message)
                        
                        indexPaths.append(IndexPath(item: countToStartWith, section: 0))
                        countToStartWith = countToStartWith + 1
                    }
                    else if message.eventtype == "reaction"
                    {
                        self.reactions.append(message)
                    }
                }
                
                if indexPaths.count > 0
                {
                    self.view.insertRowsAtIndexes(indexpaths: indexPaths)
                }
            }
        }
    }
    
    public typealias completion = () -> Void

    func sendMessage(message: String, completionHandler: @escaping completion)
    {
        let request = ChatRoomsServices.ExecuteChatCommand()
        request.roomId = roomId
        request.command = message
        request.userid = selectedUser?.userid

        view.startLoader()
        services.ams.chatRoomsServices(request) { response in
            self.view.stopLoader()
            self.getUpdates()
            completionHandler()
        }
    }
    
    func likeButtonPress(index: Int, completionHandler: @escaping completion)
    {
        let request = ChatRoomsServices.ReactToAMessageLike()
        request.roomId = roomId
        request.roomNewestEventId = messages[index].id
        request.userid = selectedUser?.userid
        request.reaction = "like"
        request.reacted = "true"
        
        services.ams.chatRoomsServices(request) { (response) in
            self.getUpdates(second: true)
            completionHandler()
        }
    }
    
    func likeCount(message:Message) -> Int
    {
        var count = 0
        
        for reaction in (message.reactions ?? [Reaction]())
        {
            if reaction.type == "like"
            {
                count = count + (reaction.count ?? 0)
            }
        }
        
        return count
    }
}

