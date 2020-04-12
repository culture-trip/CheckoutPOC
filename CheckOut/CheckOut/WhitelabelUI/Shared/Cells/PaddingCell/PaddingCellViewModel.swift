import Foundation

struct PaddingCellViewModel: CustomCellViewModel {
    
    var customPayload: CustomPayload?
    var item: CustomCellItem?
    var height: PaddingType? { return item?.height }
    var content: String? {
        
        if let content = customPayload?.content {
            return content
        }
        
        return item?.content
    }
}
