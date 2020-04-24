import Foundation

public protocol Inputting {
    
    var data: String? { get set }
}

public class InputCellViewModel: CellViewModel, Inputting {
    
    public var data: String?
    public var payload: Payload?
    public var row: Row?
    public var isSecure: Bool {
        
        return row?.isSecure ?? false
    }
    
    public var cellInputType: RowInputType? { return row?.cellInputType }
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
