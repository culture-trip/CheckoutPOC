import Foundation

struct BodyTextCellViewModel: CustomCellViewModel {
    
    var item: CustomCellItem?
    var content: String? { return item?.content}
}
