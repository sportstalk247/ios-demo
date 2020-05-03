import UIKit
import SportsTalk_iOS_SDK

protocol ChatLogView
{
    func refresh(_ firstTimeMakeUserToBottom: Bool)
    func insertRowsAtIndexes(indexpaths: [IndexPath])
    
    func refreshRowAt(indexpath: IndexPath)
    func dismiss()
    var isCollectionViewLoading: Bool { set get }
}

class ChatLogViewPresenter: NSObject
{
    private var view: ChatLogView!
    private var services: Services!
    
    var users = [User]()
    var joinedRoom: Room?
    var messages = [Message]()
    var reactions = [Message]()
    var lastEventId = ""
    
    private var internalTimer: Timer?
    private var pollingStarted = false{
        didSet{
            if pollingStarted{
                
                DispatchQueue.main.async{
                    
                    self.services.startTalk()
                    self.services.pollingUpdates = {updates in
                        self.parseMessages(response: updates as? [String: Any] ?? [:], second: true)
                    }
                    
                    /*guard self.internalTimer == nil else { return }
                    self.internalTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.checkUpdates), userInfo: nil, repeats: true)*/
                }
            }else{
                self.services.stopTalk()
                /*guard internalTimer != nil else { return }
                internalTimer?.invalidate()
                internalTimer = nil*/
            }
        }
    }
    
    deinit {
        self.services?.stopTalk()
    }
    
    @objc func checkUpdates(){
        //        getUpdates(second: true)
        self.getUpdatesMore()
    }
    
    func gettingDismissed(){
        pollingStarted = false
    }
    
    init(view: ChatLogView, services: Services)
    {
        self.view = view
        self.services = services
        super.init()
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
        
        CommonUttilities.shared.showLoader()
        
        services.ams.chatRoomsServices(request) { (response) in
            var roomJoined = false
            if let response = response["data"] as? [String: Any]
            {
                if let roomResponse = response["room"] as? [String: Any]
                {
                    roomJoined = true
                    self.joinedRoom = Room().convertIntoModel(response: roomResponse)
                    self.pollingStarted = true
                }
            }
            if !roomJoined{
                self.showMessage(message: "There was an error joining the room") { (_) in
                    self.view.dismiss()
                }
            }
            CommonUttilities.shared.hideLoader()
        }
    }
    
    
    func parseMessages(response: [String: Any], second: Bool){
        
        guard let data = response["data"] as? [String: Any],
            let events = data["events"] as? [[String:Any]] else {return}

        var messages = [Message]()
        var reactions = [Message]()
        CommonUttilities.shared.hideLoader()
        for event in events{
            
            let message = Message().convertIntoModel(response: event)
            print("event type \(message.eventtype ?? "")")
            self.lastEventId = message.id ?? ""
            
            if message.eventtype == "speech"{
                messages.append(message)
            }
            else if message.eventtype == "reaction"{
                reactions.append(message)
            }
        }
        self.messages.append(contentsOf: messages)
        self.reactions.append(contentsOf: reactions)
        self.view.refresh(second ? false : true)
    }
    
    func getUpdates(second:Bool = false)
    {
        let request = ChatRoomsServices.GetUpdates()
        request.roomId = roomId
        
        if !second
        {
            CommonUttilities.shared.showLoader()
        }
        
        services.ams.chatRoomsServices(request) { (response) in
            self.parseMessages(response: response as? [String:Any] ?? [:], second: second)
            CommonUttilities.shared.hideLoader()
        }
    }
    
    func getUpdatesMore()
    {
        let request = ChatRoomsServices.GetUpdatesMore()
        request.roomIdOrLabel = roomId
        request.eventid = self.lastEventId
        
        services.ams.chatRoomsServices(request) { (response) in
            self.parseMessages(response: response as? [String:Any] ?? [:], second: true)
        }
    }
    
    public typealias completion = () -> Void
    
    func sendMessage(message: String, completionHandler: @escaping completion)
    {
        let request = ChatRoomsServices.ExecuteChatCommand()
        request.roomId = roomId
        request.command = message
        request.userid = selectedUser?.userid
        
        CommonUttilities.shared.showLoader()
        services.ams.chatRoomsServices(request) { response in
            CommonUttilities.shared.hideLoader()
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
        
        if count == 0{
            for reaction in reactions where reaction.replyto?.id == message.id{
                for r in reaction.replyto?.reactions ?? []{
                    if r.type == "like"{
                        count+=1
                    }
                }
            }
        }
        
        return count
    }
}

