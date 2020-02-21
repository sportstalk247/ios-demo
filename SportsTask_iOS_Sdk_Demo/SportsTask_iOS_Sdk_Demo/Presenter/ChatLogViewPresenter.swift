import UIKit
import SportsTalk_iOS_SDK

protocol ChatLogView
{
    func refresh(_ firstTimeMakeUserToBottom: Bool)
    func startLoader()
    func stopLoader()
}

class ChatLogViewPresenter
{
    private var view: ChatLogView!
    private var services: Services!
    
    var users = [User]()
    var joinedRoom: Room?
    var messages = [Message]()
    var reactions = [Message]()
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
                    self.internalTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.checkUpdates), userInfo: nil, repeats: true)
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
        self.getUpdates(show: false)
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
                    
                    self.getUpdates(firstTime: true)
                    self.pollingStarted = true
                }
            }
        }
    }
    
    func getUpdates(show: Bool = true, firstTime: Bool = false)
    {
        let request = ChatRoomsServices.GetUpdates()
        request.roomId = roomId
                
        if show
        {
            view.startLoader()
        }
        
        services.ams.chatRoomsServices(request) { (response) in
            if let responseMessages = response["data"] as? [[String: Any]]
            {
                self.messages.removeAll()
                
                if show
                {
                    self.view.stopLoader()
                }
                
                for responseMessage in responseMessages
                {
                    let message = Message().convertIntoModel(response: responseMessage)
                    
                    if message.eventtype == "speech"
                    {
                        self.messages.append(message)
                    }
                    else if message.eventtype == "reaction"
                    {
                        self.reactions.append(message)
                    }
                }
                
                self.view.refresh(firstTime)
            }
        }
    }
    
    func sendMessage(message: String)
    {
        let request = ChatRoomsServices.ExecuteChatCommand()
        request.roomId = roomId
        request.command = message
        request.userid = selectedUser?.userid

        view.startLoader()
        services.ams.chatRoomsServices(request) { _ in
            self.view.stopLoader()
            self.getUpdates()
        }
    }
}

