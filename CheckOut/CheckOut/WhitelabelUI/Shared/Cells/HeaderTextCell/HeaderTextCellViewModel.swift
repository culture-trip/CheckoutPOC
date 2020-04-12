struct HeaderTextCellViewModel: CustomCellViewModel {
    
    var item: CustomCellItem?
    var alignment: CellAlignmentType { return item?.alignment ?? .left}
    var content: String? { return item?.content}
}
