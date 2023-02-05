//
//  CommentClient.swift
//  SportsTalk247
//
//  Created by Lawrence Cendana on 1/15/23.
//  Copyright © 2023 krishna41. All rights reserved.
//

import Foundation

public protocol CommentClientProtocol {
    func createOrUpdateConversation(_ request: CommentRequest.CreateUpdateConversation, completionHandler: @escaping Completion<Conversation>)
    func getConversation(_ request: CommentRequest.GetConversationById, completionHandler: @escaping Completion<Conversation>)
    func getConversationByCustomId(_ request: CommentRequest.FindConversationByIdCustomId, completionHandler: @escaping Completion<Conversation>)
    func listConversations(_ request: CommentRequest.ListConversations, completionHandler: @escaping Completion<ListConversationsResponse>)
    func batchGetConversationDetails(_ request: CommentRequest.GetBatchConversationDetails, completionHandler: @escaping Completion<BatchGetConversationDetailsResponse>)
    func reactToConversationTopic(_ request: CommentRequest.ReactToConversationTopic, completionHandler: @escaping Completion<Conversation>)
    func createComment(_ request: CommentRequest.CreateComment, completionHandler: @escaping Completion<Comment>)
    func replyToComment(_ request: CommentRequest.ReplyToComment, completionHandler: @escaping Completion<Comment>)
    func listCommentReplies(_ request: CommentRequest.ListCommentReplies, completionHandler: @escaping Completion<ListCommentsResponse>)
    func getComment(_ request: CommentRequest.GetCommentDetails, completionHandler: @escaping Completion<Comment>)
    func listComments(_ request: CommentRequest.ListComments, completionHandler: @escaping Completion<ListCommentsResponse>)
    func listCommentRepliesBatch(_ request: CommentRequest.GetBatchCommentReplies, completionHandler: @escaping Completion<ListCommentRepliesBatchResponse>)
    func reactToComment(_ request: CommentRequest.ReactToComment, completionHandler: @escaping Completion<Comment>)
    func voteOnComment(_ request: CommentRequest.VoteOnComment, completionHandler: @escaping Completion<Comment>)
    func reportComment(_ request: CommentRequest.ReportComment, completionHandler: @escaping Completion<Comment>)
    func updateComment(_ request: CommentRequest.UpdateComment, completionHandler: @escaping Completion<Comment>)
    func flagCommentLogicallyDeleted(_ request: CommentRequest.FlagCommentLogicallyDeleted, completionHandler: @escaping Completion<DeleteCommentResponse>)
    func permanentlyDeleteComment(_ request: CommentRequest.PermanentlyDeleteComment, completionHandler: @escaping Completion<DeleteCommentResponse>)
    func deleteConversation(_ request: CommentRequest.DeleteConversation, completionHandler: @escaping Completion<DeleteConversationResponse>)
    func listCommentsInModerationQueue(_ request: CommentModerationRequest.ListCommentsInModerationQueue, completionHandler: @escaping Completion<ListCommentsResponse>)
    func approveMessageInQueue(_ request: CommentModerationRequest.ApproveRejectComment, completionHandler: @escaping Completion<Comment>)
    
}

public class CommentClient: NetworkService, CommentClientProtocol {
    public override init(config: ClientConfig) {
        super.init(config: config)
    }
}

extension CommentClient {
    public func createOrUpdateConversation(_ request: CommentRequest.CreateUpdateConversation, completionHandler: @escaping Completion<Conversation>) {
        makeRequest(
            URLPath.Conversation.CreateUpdate(),
            withData: request.toDictionary(),
            requestType: .POST,
            expectation: Conversation.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func getConversation(_ request: CommentRequest.GetConversationById, completionHandler: @escaping Completion<Conversation>) {
        makeRequest(
            URLPath.Conversation.Details(conversationid: request.conversationid),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: Conversation.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func getConversationByCustomId(_ request: CommentRequest.FindConversationByIdCustomId, completionHandler: @escaping Completion<Conversation>) {
        makeRequest(
            URLPath.Conversation.DetailsByCustomId(),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: Conversation.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listConversations(_ request: CommentRequest.ListConversations, completionHandler: @escaping Completion<ListConversationsResponse>) {
        makeRequest(
            URLPath.Conversation.List(),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: ListConversationsResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func batchGetConversationDetails(_ request: CommentRequest.GetBatchConversationDetails, completionHandler: @escaping Completion<BatchGetConversationDetailsResponse>) {
        makeRequest(
            URLPath.Conversation.BatchConversationDetails(),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: BatchGetConversationDetailsResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func reactToConversationTopic(_ request: CommentRequest.ReactToConversationTopic, completionHandler: @escaping Completion<Conversation>) {
        makeRequest(
            URLPath.Conversation.React(conversationid: request.conversationid),
            withData: request.toDictionary(),
            requestType: .POST,
            expectation: Conversation.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func createComment(_ request: CommentRequest.CreateComment, completionHandler: @escaping Completion<Comment>) {
        makeRequest(
            URLPath.Comment.Create(conversationid: request.conversationid),
            withData: request.toDictionary(),
            requestType: .POST,
            expectation: Comment.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func replyToComment(_ request: CommentRequest.ReplyToComment, completionHandler: @escaping Completion<Comment>) {
        makeRequest(
            URLPath.Comment.Reply(conversationid: request.conversationid, commentid: request.replytocommentid),
            withData: request.toDictionary(),
            requestType: .POST,
            expectation: Comment.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listCommentReplies(_ request: CommentRequest.ListCommentReplies, completionHandler: @escaping Completion<ListCommentsResponse>) {
        makeRequest(
            URLPath.Comment.ListReplies(conversationid: request.conversationid, commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: ListCommentsResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func getComment(_ request: CommentRequest.GetCommentDetails, completionHandler: @escaping Completion<Comment>) {
        makeRequest(
            URLPath.Comment.Details(conversationid: request.conversationid, commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: Comment.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listComments(_ request: CommentRequest.ListComments, completionHandler: @escaping Completion<ListCommentsResponse>) {
        makeRequest(
            URLPath.Comment.List(conversationid: request.conversationid),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: ListCommentsResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listCommentRepliesBatch(_ request: CommentRequest.GetBatchCommentReplies, completionHandler: @escaping Completion<ListCommentRepliesBatchResponse>) {
        makeRequest(
            URLPath.Comment.BatchReplies(conversationid: request.conversationid),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: ListCommentRepliesBatchResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func reactToComment(_ request: CommentRequest.ReactToComment, completionHandler: @escaping Completion<Comment>) {
        makeRequest(
            URLPath.Comment.React(conversationid: request.conversationid, commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .POST,
            expectation: Comment.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func voteOnComment(_ request: CommentRequest.VoteOnComment, completionHandler: @escaping Completion<Comment>) {
        makeRequest(
            URLPath.Comment.Vote(conversationid: request.conversationid, commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .POST,
            expectation: Comment.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func reportComment(_ request: CommentRequest.ReportComment, completionHandler: @escaping Completion<Comment>) {
        makeRequest(
            URLPath.Comment.Report(conversationid: request.conversationid, commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .POST,
            expectation: Comment.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func updateComment(_ request: CommentRequest.UpdateComment, completionHandler: @escaping Completion<Comment>) {
        makeRequest(
            URLPath.Comment.Update(conversationid: request.conversationid, commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .PUT,
            expectation: Comment.self,
            append: false
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func flagCommentLogicallyDeleted(_ request: CommentRequest.FlagCommentLogicallyDeleted, completionHandler: @escaping Completion<DeleteCommentResponse>) {
        makeRequest(
            URLPath.Comment.LogicallyDeleted(conversationid: request.conversationid, commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .PUT,
            expectation: DeleteCommentResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func permanentlyDeleteComment(_ request: CommentRequest.PermanentlyDeleteComment, completionHandler: @escaping Completion<DeleteCommentResponse>) {
        makeRequest(
            URLPath.Comment.PermanentlyDelete(conversationid: request.conversationid, commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .DELETE,
            expectation: DeleteCommentResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func deleteConversation(_ request: CommentRequest.DeleteConversation, completionHandler: @escaping Completion<DeleteConversationResponse>) {
        makeRequest(
            URLPath.Conversation.Delete(conversationid: request.conversationid),
            withData: request.toDictionary(),
            requestType: .DELETE,
            expectation: DeleteConversationResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func listCommentsInModerationQueue(_ request: CommentModerationRequest.ListCommentsInModerationQueue, completionHandler: @escaping Completion<ListCommentsResponse>) {
        makeRequest(
            URLPath.Comment.Mod.List(),
            withData: request.toDictionary(),
            requestType: .GET,
            expectation: ListCommentsResponse.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
    
    public func approveMessageInQueue(_ request: CommentModerationRequest.ApproveRejectComment, completionHandler: @escaping Completion<Comment>) {
        makeRequest(
            URLPath.Comment.Mod.ApproveReject(commentid: request.commentid),
            withData: request.toDictionary(),
            requestType: .POST,
            expectation: Comment.self
        ) { (response) in
            completionHandler(response?.code, response?.message, response?.kind, response?.data)
        }
    }
}
