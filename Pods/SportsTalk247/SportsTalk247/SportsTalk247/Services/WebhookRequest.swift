import Foundation

public class WebhookRequest {
    
    /// Creates a new webhook or updates an existing webhook
    ///
    /// BEHAVIOR: CREATE OR UPDATE
    /// If the label is already in use by a webhook in the system, this will re-create the webhook, replacing what is in the database with the new settings you passed in.
    ///
    /// WEBHOOK TYPES
    /// There are two types of webhook: prepublish and postpublish.
    ///
    /// PRE-PUBLISH WEBHOOK
    /// Pass "prepublish" for the type parameter to create this type of webhook. This webhook will fire before the event is fired. If the remote system responds with 200 then the message will continue through the pipeline to be published. If you have more than one prepublish webhook, if any respond with other than 200 the message will be blocked. An example of when you would use a pre-publish webhook is when you want to perform pre-moderation with an external system.
    ///
    ///  POST-PUBLISH WEBHOOK
    ///  Pass "postpublish" for the type parameter to create this type of webhook. This webhook will fire after an event is published. The reponse from the remote service is ignored. An example of a post publish webhook would be using post moderation with an external system.
    ///
    ///  EVENT TYPES
    ///  The following event types are supported.
    ///  * chatcustom
    ///  * chatspeech
    ///  * chatquote
    ///  * chatreply
    ///  * chatreaction
    ///  * chataction
    ///  * chatenter
    ///  * chatexit
    ///  * chatroomopened
    ///  * chatroomclosed
    ///  * chatpurge
    ///  * commentpublished
    ///  * commentreply
    ///
    /// Arguments:
    ///  label : (required) A unique string for your webhook. It can be anything you want.
    ///  url: (required) A URL to post to when the webhook is activated.
    ///  enabled: (required) Sets the webhook to be in either the enabled or disabled states.
    ///  type: (required) ["prepublish"/"postpublish"] Sets the type of webhook. See TYPES below.
    ///  events: (required) An array of strings indicating which event types activate your webhook. See events below for allowed values.
    /// - Warning: Requires Authentication.
    public class CreateReplaceWebhook: ParametersBase<CreateReplaceWebhook.Fields, CreateReplaceWebhook> {
        public enum Fields {
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

        override public func from(dictionary: [AnyHashable: Any]) -> CreateReplaceWebhook {
            set(dictionary: dictionary)
            let ret = CreateReplaceWebhook()

            ret.label = value(forKey: .label)
            ret.url = value(forKey: .url)
            ret.enabled = value(forKey: .enabled)
            ret.type = value(forKey: .type)
            ret.events = value(forKey: .events)

            return ret
        }

        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()

            addRequired(key: .label, value: label)
            addRequired(key: .url, value: url?.absoluteString)
            addRequired(key: .enabled, value: enabled)
            addRequired(key: .type, value: type)
            addRequired(key: .events, value: events)

            return toDictionary
        }
    }
    
    /// Gets a list of webhooks
    /// - Warning: This method requires authentication
    public class ListWebhooks {
        public init() {}
        
        public func from(dictionary: [AnyHashable: Any]) -> ListWebhooks {
            let ret = ListWebhooks()
            return ret
        }

        public func toDictionary() -> [AnyHashable: Any] {
            return [AnyHashable: Any]()
        }
    }
    
    /// Updates an exisiting webhook by replacing its properties with the new values
    ///
    /// BEHAVIOR: CREATE OR UPDATE
    /// If the label is already in use by a webhook in the system, this will re-create the webhook, replacing what is in the database with the new settings you passed in.
    ///
    /// WEBHOOK TYPES
    /// There are two types of webhook: prepublish and postpublish.
    ///
    /// PRE-PUBLISH WEBHOOK
    /// Pass "prepublish" for the type parameter to create this type of webhook. This webhook will fire before the event is fired. If the remote system responds with 200 then the message will continue through the pipeline to be published. If you have more than one prepublish webhook, if any respond with other than 200 the message will be blocked. An example of when you would use a pre-publish webhook is when you want to perform pre-moderation with an external system.
    ///
    ///  POST-PUBLISH WEBHOOK
    ///  Pass "postpublish" for the type parameter to create this type of webhook. This webhook will fire after an event is published. The reponse from the remote service is ignored. An example of a post publish webhook would be using post moderation with an external system.
    ///
    ///  EVENT TYPES
    ///  The following event types are supported.
    ///  * chatcustom
    ///  * chatspeech
    ///  * chatquote
    ///  * chatreply
    ///  * chatreaction
    ///  * chataction
    ///  * chatenter
    ///  * chatexit
    ///  * chatroomopened
    ///  * chatroomclosed
    ///  * chatpurge
    ///  * commentpublished
    ///  * commentreply
    ///
    /// Arguments:
    ///  label : (required) A unique string for your webhook. It can be anything you want.
    ///  url: (required) A URL to post to when the webhook is activated.
    ///  enabled: (required) Sets the webhook to be in either the enabled or disabled states.
    ///  type: (required) ["prepublish"/"postpublish"] Sets the type of webhook. See TYPES below.
    ///  events: (required) An array of strings indicating which event types activate your webhook. See events below for allowed values.
    /// - Warning: Requires Authentication.
    public class UpdateWebhook: ParametersBase<UpdateWebhook.Fields, UpdateWebhook> {
        public enum Fields {
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

        override public func from(dictionary: [AnyHashable: Any]) -> UpdateWebhook {
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

        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()

            add(key: .id, value: webhookId)
            add(key: .label, value: label)
            add(key: .url, value: url?.absoluteString)
            add(key: .enabled, value: enabled)
            add(key: .type, value: type)
            add(key: .events, value: events)
            
            addRequired(key: .id, value: webhookId)
            addRequired(key: .label, value: label)
            addRequired(key: .url, value: url?.absoluteString)
            addRequired(key: .enabled, value: enabled)
            addRequired(key: .type, value: type)
            addRequired(key: .events, value: events)

            return toDictionary
        }
    }
    
    /// Deletes the specified webhook by ID
    /// - Warning: This method requires authentication
    public class DeleteWebhook: ParametersBase<UpdateWebhook.Fields, DeleteWebhook> {
        public enum Fields {
            case id
        }
        
        public var webhookId:String?
        
        override public func from(dictionary: [AnyHashable: Any]) -> DeleteWebhook {
            let ret = DeleteWebhook()
            ret.webhookId = value(forKey: .id)
            
            return ret
        }
        
        public func toDictionary() -> [AnyHashable: Any] {
            toDictionary = [AnyHashable: Any]()
            
            addRequired(key: .id, value: webhookId)
            
            return toDictionary
        }
    }
}
