struct HeaderTextCellViewModel: CustomCellViewModel {
    
    var customPayload: CustomPayload?
    var item: CustomCellItem?
    var alignment: CellAlignmentType { return item?.alignment ?? .left}
    
    var content: String? {
        
        if let content = customPayload?.content {
            return content
        }
        
        return item?.content
    }
}
