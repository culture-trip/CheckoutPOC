struct HeaderTextCellViewModel: CustomCellViewModel {
    
    var payload: Payload?
    var item: CustomCellItem?
    var alignment: CellAlignmentType { return item?.alignment ?? .left}
    
    var content: String? {
        
        if let content = payload?.content {
            return content
        }
        
        return item?.content
    }
}
