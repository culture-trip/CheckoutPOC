import Foundation

struct InputCellViewModel: CustomCellViewModel {
    
    var payload: Payload?
    var item: CustomCellItem?
    var cellInputType: CellInputType? { return item?.cellInputType }
    var content: String? {
        
        if let content = payload?.content {
            return content
        }
        
        return item?.content
    }
}
