import Foundation

public struct User
{
    var userId = ""
    var handle = ""
}

open class Services
{
    let baseUrl = URL(string: "https://api.sportstalk247.com/api/v3") // http://api-origin.sportstalk247.com/api/v3
    
    private var _authToken: String?
    private lazy var _url: URL? = baseUrl
    private var _ams = ServicesAMS()
    
    internal var knownRooms: [[AnyHashable: Any]]?
    internal var _updatesApi: String?
    internal var _roomApi: String?
    internal var _commandApi: String?
    internal lazy var _endpoint = _url
    internal var _currentRoom: [AnyHashable: Any]?
    private var _user = User(userId: "", handle: "")
    public var pollingUpdates: [AnyHashable: Any]?
    
    private var _polling = false
    {
        didSet
        {
            if _polling
            {
                startPolling()
            }
            else
            {
                stopPolling()
            }
        }
    }
    
    var interval: Timer?
    
    open var user: User
    {
        get
        {
            return _user
        }
        set
        {
            _user = newValue
        }
    }
    
    open var ams: ServicesAMS
    {
        get
        {
            return _ams
        }
        set
        {
            _ams = newValue
        }
    }

    open var authToken: String?
    {
        get
        {
            return _authToken
        }
        set
        {
            _authToken = newValue
            self.ams.authToken = newValue
        }
    }

    open var url: URL?
    {
        get
        {
            return _url
        }
        set
        {
            _url = newValue
            self.ams.url = newValue
            self.services = self
        }
    }
    
    open var services: Services?

    public init() { }
    
    public func stopTalk()
    {
        if _polling
        {
            _polling = !_polling
        }
    }
    
    public func startTalk()
    {
        if _polling
        {
            return
        }
        
        _polling = !_polling
    }
    
    func startPolling()
    {
        DispatchQueue.main.async {
            self.interval = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startPollingTimer), userInfo: nil, repeats: true)
        }
    }
    
    func stopPolling()
    {
        interval?.invalidate()
    }
    
    @objc func startPollingTimer()
    {
        ams.getUpdates { (response) in
            self.pollingUpdates = response
        }
    }
}
