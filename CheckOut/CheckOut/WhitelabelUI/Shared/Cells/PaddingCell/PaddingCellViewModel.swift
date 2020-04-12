import Foundation

struct PaddingCellViewModel: CustomCellViewModel {
    var item: CustomCellItem?
    var height: PaddingType? { return item?.height }
}
