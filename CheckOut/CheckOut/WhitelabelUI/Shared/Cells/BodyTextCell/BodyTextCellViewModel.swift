import Foundation

struct BodyTextCellViewModel: CustomCellViewModel {
    var customPayload: CustomPayload?
    var item: CustomCellItem?
    var content: String? {
        
        if let content = customPayload?.content {
            return content
        }
        
        return item?.content
    }
}
