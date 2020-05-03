# Sportstalk 247 iOS SDK

## Usage
The Sportstalk SDK is a helpful wrapper around the [Sportstalk API](https://apiref.sportstalk247.com/?version=latest)

The set of SDKs and source (iOS, Android, and JS) is here: [https://gitlab.com/sportstalk247/](https://gitlab.com/sportstalk247/)


```bash
pod 'SportsTalk_iOS_SDK', :git=> 'https://gitlab.com/sportstalk247/sdk-ios-swift.git'
```
You will need to register with SportsTalk and get an API Key in order to use sportstalk functions.


## GETTING STARTED: How to use the SDK
This Sportstalk SDK is meant to power custom chat applications.  Sportstalk does not enforce any restricitons on your UI design, but instead empowers your developers to focus on the user experience without worrying about the underlying chat behavior.

Sportstalk is an EVENT DRIVEN API. When new talk events occur, the SDK will trigger appropriate callbacks, if set.
At minimum, you will want to set 5 callbacks:

*ExecuteChat 
*PurgeMessages
*ReactToMessage
*AdminCommand

See a simple example below:

```python
import SportsTalk_iOS_SDK

// first create a service
let services = Services()
services.authToken = "YourApiKeyHere"

// You can set the event handlers.
services.ams.chatRoomsServices(ChatRoomsServices.ExecuteChatCommand()) { _ in }
services.ams.moderationServies(ModerationServices.PurgeUserMessages()) { _ in }
services.ams.chatRoomsServices(ChatRoomsServices.ReactToAMessageLike()) { _ in }
services.ams.chatRoomsServices(ChatRoomsServices.ExecuteAdminCommand()) { _ in }

// Set the user, if logged in.
services.user = User(userId: UserId, handle: Handle)

// List rooms, join a room
services.ams.listRooms { _ in
    services.ams.joinRoom(room: services.knownRooms.first)
}
...
```
For use of these events in action, see the demo page: [https://www.sportstalk247.com/demo.html](https://www.sportstalk247.com/demo.html)


## Callback function overview 

Each and every api function has its callback, when the api is called you will get the response in the callback. You can use this to remove loading screens, hide advertisements, and so on.

### Execute Chat Command
This is the most critical callback. Each **new** chat event seen by the sdk client instance will be passed to this callback.  It is possible to render the entire chat experience with just this callback.
Your UI solution should accept each chat event and render it.  This callback could also be used to trigger push notifications.

### onGoalEvent(event: EventResult)
This is a **convenience wrapper** that only works with the built-in SDK `sendGoal`.  These methods make use of the custom event types exposed by the sportstalk REST api and are purely to make creating sports experiences simpler. The REST SportsTalk api does not understand a 'goal' event, but utilizes custom event types.  This call back should only be used if you are also using the defaults provided by `client.sendGoal()`.
**Note that if this callback is registered, these custom goal events will NOT be sent to `onChatEvent`**

### Reply To A Message
This is the event used for making a reply to a reply **instead of** using `Execute Chat Command` 

### React To A Message
If both are set, onReaction will be called **instead of** `Execute Chat Command`  for reply events.

### Purge Messages
Clients should implement `PurgeUserMessages` if there is any moderation.  Purge events are used by the sportstalk SDK to let clients to know to remove messages that have been moderated as harmful or against policies and should be removed from the UI.

### Admin Command
`ExecuteAdminCommand` will be triggered on a successful server response when an admin command **is sent**.  For instance, if an admin sends a purge command, `ExecuteAdminCommand` will be triggered when the purge command is sent, and `PurgeUserMessages` will be triggered with the purge message is sent from the API.

Note that if `onHelp` is set it will be triggered instead of onAdminCommand because there may be special considerations - loading a different screen, navigating to a website, etc.


## The Bare Minimum
The only critical events that you need to handle are `ExecuteChatCommand` which will be called for each new chat event, `ExecuteAdminCommand` which will handle messages from administrators, `PurgeUserMessages` which will be called when purge commands are issued to clear messages that violate content policy.

You will probably also want to use `ExecuteChatCommand` to show/hide any loading messages.

The easiest way to see how these event works is to see the demo page: https://www.sportstalk247.com/demo.html

# Chat Application Best Practices
* Do not 'fire and forget' chat messages.  Most chat applications require some level of moderation.  Your UI should make sure to keep track of message metadata such as:
    * Message ID
    * User Handle for each message.
    * User ID for each message.  In the event of moderation or purge events,  your app will need to be able to find and remove purged messages.
    * Timestamp
* Use the promises from sendCommand, sendReply, etc, to show/hide some sort of indication that the message is being sent.
* Make sure you handle errors for sending messages in case of network disruption.   For instance, `client.sendCommand('message').catch(handleErrorInUiFn)`

## Copyright & License

Copyright (c) 2019 Sportstalk247
