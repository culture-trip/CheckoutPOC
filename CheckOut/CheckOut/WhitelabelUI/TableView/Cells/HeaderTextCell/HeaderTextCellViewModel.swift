public class HeaderTextCellViewModel: CellViewModel {
    
    public var payload: Payload?
    public var row: Row?
    public var alignment: RowAlignmentType { return row?.alignment ?? .left}
    public var content: String? {
        
        if let content = payload?.content {
            return content
        }
        
        return row?.content
    }
    
    required public init(row: Row?, payload: Payload?) {
        
        self.row = row
        self.payload = payload
    }
}
