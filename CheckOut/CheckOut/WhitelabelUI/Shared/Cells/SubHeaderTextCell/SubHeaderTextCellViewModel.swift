import Foundation

struct SubHeaderTextCellViewModel: CustomCellViewModel {
    
    var payload: Payload?
    var item: Row?
    var content: String? {
        
        if let content = payload?.content {
            return content
        }
        
        return item?.content
    }
}
