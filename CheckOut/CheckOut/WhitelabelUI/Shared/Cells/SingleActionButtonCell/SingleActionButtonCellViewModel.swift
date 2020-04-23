import Foundation

struct SingleActionButtonCellViewModel: CustomCellViewModel {
    
    var payload: Payload?
    var item: Row?
    var action: Action? {
        
        return item?.action
    }
    var content: String? {
        
        if let content = payload?.content {
            return content
        }
        
        return item?.content
    }
}
