import Foundation
import SportsTalk_iOS_SDK

protocol CommentsView{
    func showData()
    func messageSent(success: Bool)
    func updateRow(index: Int, isNew: Bool)
}

class CommentsViewPresenter: NSObject {
    private var services: Services!
    private var view: CommentsView!
    var array = [Comment]()
    init(services: Services, view: CommentsView){
           self.services = services
           self.view = view
           super.init()
           loadData()
    }
    
    func loadData(isRefreshing: Bool = false){
        let request = CommentsService.ListComments()
        request.comment_conversation_id = conversation?.conversationid
        request.includechildren = true
        request.includeinactive = true
        if !isRefreshing{
            CommonUttilities.shared.showLoader()
        }
        services.ams.commentsServices(request) { (response) in
              if let data = response["data"] as? [String : Any], let array = data["comments"] as? NSArray{
                  self.parseData(array: array)
              }
            CommonUttilities.shared.hideLoader()
        }
    }
    
    func parseData(array: NSArray){
        self.array.removeAll()
        for element in array{
            if let object = element as? [String: Any]{
                let model = Comment.from(dict: object)
                self.array.append(model)
            }
        }
        view.showData()
    }
    
    func isAlreadyReported(model: Comment) -> Bool{
        
        if let reports = model.reports{
            for report in reports{
                if report.userid == selectedUser?.userid ?? ""{
                    return true
                }
            }
        }
        return false
    }
    
    func isAlreadyLiked(model: Comment) -> Bool{
        var alreadyLiked = false
        if let reactions = model.reactions{
            if let reaction = reactions.first(where: {$0.type == "like"}){
                if let users = reaction.users{
                    if let _ = users.first(where: {$0.userid == selectedUser?.userid ?? ""}){
                        alreadyLiked = true
                    }
                }
            }
        }
        return alreadyLiked
    }
    
    func sendComment(text: String){
        let request = CommentsService.CreateAndPublishComment()
        request.comment_conversation_id = conversation?.conversationid
        request.body = text
        request.userid = selectedUser?.userid ?? ""
        services.ams.commentsServices(request) { (response) in
            if let data = response["data"] as? [String: Any]{
                let model = Comment.from(dict: data)
                self.view.messageSent(success: true)
                self.updateMode(model: model)
            }else{
                self.showMessage(message: "There was an error while sending the comment") { (_) in
                    self.view.messageSent(success: false)
                }
            }
        }
        
    }
    
    func reportComment(model: Comment) {
        if isAlreadyReported(model: model){
            showMessage(message: "You've already reported this comment", completion: {_ in})
        }else{
            
            showMessage(message: "Do you really want to report this comment", positiveButtonText: "Yes", negativeButtonText: "No") { (report) in
                if report{
                    let request = CommentsService.ReportComment()
                    request.comment_conversation_id = model.conversationid
                    request.comment_comment_id = model.id
                    request.reporttype = "abuse"
                    request.userid = selectedUser?.userid ?? ""
                    self.services.ams.commentsServices(request) { (response) in
                        if let data = response["data"] as? [String:Any]{
                            let model = Comment.from(dict: data)
                            self.updateMode(model: model)
                        }
                    }
                }
            }
        }
    }
    
    func likeComment(model: Comment) {
        let alreadyLiked = isAlreadyLiked(model: model)
        let request = CommentsService.ReactToCommentLike()
        request.comment_conversation_id = model.conversationid
        request.comment_comment_id = model.id
        request.reacted = alreadyLiked ? false : true
        request.reaction = "like"
        request.userid = selectedUser?.userid ?? ""
        services.ams.commentsServices(request) { (response) in
            if let data = response["data"] as? [String: Any]{
                let m = Comment.from(dict: data)
                self.updateMode(model: m)
            }
        }
    }
    
    func updateMode(model: Comment){
        if let index = array.firstIndex(where: {$0.id == model.id}){
            array[index] = model
            view.updateRow(index: index, isNew: false)
        }else{
            array.append(model)
            view.updateRow(index: array.count-1, isNew: true)
        }
    }
}
