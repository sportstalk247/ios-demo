import Foundation

public class WebhooksServices
{
    public class CreateReplaceWebhook: ParametersBase<CreateReplaceWebhook.Fields, CreateReplaceWebhook>
    {
        public enum Fields
        {
            case label
            case url
            case enabled
            case type
            case events
        }

        public var label: String?
        public var url: URL?
        public var enabled: Bool?
        public var type: String?
        public var events: [String]?

        override public func from(dictionary: [AnyHashable: Any]) -> CreateReplaceWebhook
        {
            set(dictionary: dictionary)
            let ret = CreateReplaceWebhook()

            ret.label = value(forKey: .label)
            ret.url = value(forKey: .url)
            ret.enabled = value(forKey: .enabled)
            ret.type = value(forKey: .type)
            ret.events = value(forKey: .events)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .label, value: label)
            addRequired(key: .url, value: url?.absoluteString)
            addRequired(key: .enabled, value: enabled)
            addRequired(key: .type, value: type)
            addRequired(key: .events, value: events)

            return toDictionary
        }
    }
    
    public class ListWebhooks
    {
        public init()
        {
            
        }
        
        public func from(dictionary: [AnyHashable: Any]) -> ListWebhooks
        {
            let ret = ListWebhooks()

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            return [AnyHashable: Any]()
        }
    }
    
    public class UpdateWebhook: ParametersBase<UpdateWebhook.Fields, UpdateWebhook>
    {
        public enum Fields
        {
            case id
            case label
            case url
            case enabled
            case type
            case events
        }

        public var webhookId:String?
        public var label: String?
        public var url: URL?
        public var enabled: Bool?
        public var type: String?
        public var events: [String]?

        override public func from(dictionary: [AnyHashable: Any]) -> UpdateWebhook
        {
            set(dictionary: dictionary)
            let ret = UpdateWebhook()

            ret.webhookId = value(forKey: .id)
            ret.label = value(forKey: .label)
            ret.url = value(forKey: .url)
            ret.enabled = value(forKey: .enabled)
            ret.type = value(forKey: .type)
            ret.events = value(forKey: .events)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any]
        {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .id, value: webhookId)
            addRequired(key: .label, value: label)
            addRequired(key: .url, value: url?.absoluteString)
            addRequired(key: .enabled, value: enabled)
            addRequired(key: .type, value: type)
            addRequired(key: .events, value: events)

            return toDictionary
        }
    }
    
    public class DeleteWebhook: ParametersBase<UpdateWebhook.Fields, DeleteWebhook>
    {
        public enum Fields
        {
            case id
        }
        
        public var webhookId:String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> DeleteWebhook
        {
            let ret = DeleteWebhook()
            ret.webhookId = value(forKey: .id)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any]
        {
            
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .id, value: webhookId)
            
            return toDictionary
            
        }
    }
}
