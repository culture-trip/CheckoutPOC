import Foundation

struct InputCellViewModel: CustomCellViewModel {
    
    var customPayload: CustomPayload?
    var item: CustomCellItem?
    var cellInputType: CellInputType? { return item?.cellInputType }
    var content: String? {
        
        if let content = customPayload?.content {
            return content
        }
        
        return item?.content
    }
}
