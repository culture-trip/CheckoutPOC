import Foundation

public class PaddingCellViewModel: CellViewModel {
    
    public var payload: Payload?
    public var row: Row?
    public var height: PaddingType? { return row?.height }
    public var content: String? {
        
        if let content = payload?.content {
            return content
        }
        
        return row?.content
    }
    
    public required init(row: Row?, payload: Payload?) {
        
        self.row = row
        self.payload = payload
    }
}
