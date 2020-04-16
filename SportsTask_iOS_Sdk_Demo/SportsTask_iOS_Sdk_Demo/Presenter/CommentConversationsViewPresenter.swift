import Foundation
import SportsTalk_iOS_SDK

protocol CommentConversationsView {
    func showData()
    func goToCommentsScreen()
}
class CommentConversationsViewPresenter{
    private var services: Services!
    private var view: CommentConversationsView!
    var array = [CommentConversation]()
    init(services: Services, view: CommentConversationsView){
        self.services = services
        self.view = view
        loadData()
    }
    
    func loadData(){
        let request = CommentsService.ListConversations()
        CommonUttilities.shared.showLoader()
        services.ams.commentsServies(request) {response in
            if let data = response["data"] as? [String : Any], let array = data["conversations"] as? NSArray{
                self.parseData(array: array)
                CommonUttilities.shared.hideLoader()
            }
        }
    }
    func parseData(array: NSArray){
        self.array.removeAll()
        for element in array{
            if let object = element as? [String: Any]{
                let model = CommentConversation.from(dict: object)
                self.array.append(model)
            }
        }
        view.showData()
    }
    
    func didSelectConversation(index: Int){
        conversation = array[index]
        view.goToCommentsScreen()
    }
}
