import Foundation

struct PaddingCellViewModel: CustomCellViewModel {
    
    var payload: Payload?
    var item: Row?
    var height: PaddingType? { return item?.height }
    var content: String? {
        
        if let content = payload?.content {
            return content
        }
        
        return item?.content
    }
}
