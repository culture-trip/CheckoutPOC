import Foundation

struct SubHeaderTextCellViewModel: CustomCellViewModel {
    var item: CustomCellItem?
    var content: String? { return item?.content}
}
