import Foundation

public protocol Inputting {
    
    var data: String? { get set }
    var isHighlighted: Bool? { get set }
    var actionBlock: CellActionBlock? { get set }
    
    func setHighlighted(_ isHighlighted: Bool)
}

public class InputCellViewModel: CellViewModel, Inputting {
    
    public var data: String?
    public var payload: Payload?
    public var row: Row?
    public var isHighlighted: Bool?
    public var isSecure: Bool {
        
        return row?.isSecure ?? false
    }
    public var title: String? {
        return row?.title
    }
    public var errorTitle: String? {
        return row?.errorTitle
    }
    public func setHighlighted(_ isHighlighted: Bool) {
        
        self.isHighlighted = isHighlighted
    }
    public var actionBlock: CellActionBlock?
    
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
    
    convenience public required init(row: Row?, payload: Payload?, actionBlock: CellActionBlock?) {
        
        self.init(row: row, payload: payload)
        self.actionBlock = actionBlock
    }
}
