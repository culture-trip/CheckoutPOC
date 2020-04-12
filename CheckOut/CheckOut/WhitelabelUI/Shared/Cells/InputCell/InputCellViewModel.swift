import Foundation

struct InputCellViewModel: CustomCellViewModel {
    
    var item: CustomCellItem?
    var cellInputType: CellInputType? { return item?.cellInputType }
    var content: String? { return item?.content}
}
