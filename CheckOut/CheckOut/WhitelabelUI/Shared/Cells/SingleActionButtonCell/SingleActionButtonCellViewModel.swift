import Foundation

struct SingleActionButtonCellViewModel: CustomCellViewModel {
    
    var customPayload: CustomPayload?
    var item: CustomCellItem?
    var content: String? {
        
        if let content = customPayload?.content {
            return content
        }
        
        return item?.content
    }
}
