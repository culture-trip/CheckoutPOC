import Foundation

struct SingleActionButtonCellViewModel: CustomCellViewModel {
    
    var item: CustomCellItem?
    var content: String? { return item?.content}
}
