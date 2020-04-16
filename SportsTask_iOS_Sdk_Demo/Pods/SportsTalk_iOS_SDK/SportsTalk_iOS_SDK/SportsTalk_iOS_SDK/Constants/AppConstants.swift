import Foundation

let acceptHeaderTitle = "Accept"
let contentTypeTitle = "Content-Type"
let tokenTitle = "x-api-token"

let acceptHeaderValue = "application/json"
//let contentTypeValue = "application/x-www-form-urlencoded"
let contentTypeValue = "application/json"

let messageTitle = "Message"
let errorMessageTitle = "errorMessage"
let errorMessageString = "Enter a valid"
let jsonParsingError = "Error parsing json -"
let httpError = "HTTP Error:"

let emptyString = ""

let defaultLimit = "100"

struct ServiceKeys {
    static let user = "user/users/"
    static let chat = "chat/rooms/"
    static let chatModeration = "chat/moderation/queues/events/"
    static let webHooks = "webhook/hooks/"
    static let comments = "comment/conversations/"
}
