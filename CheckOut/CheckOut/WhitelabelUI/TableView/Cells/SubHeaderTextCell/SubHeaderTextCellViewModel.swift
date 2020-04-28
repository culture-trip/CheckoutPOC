import Foundation

class SubHeaderTextCellViewModel: CellViewModel {
    
    var payload: Payload?
    var row: Row?
    var content: String? {
        
        if let content = payload?.content {
            return content
        }
        
        return row?.content
    }
    var isBordered: Bool? {
        
        return row?.isBordered
    }
    required init(row: Row?, payload: Payload?) {
        
        self.row = row
        self.payload = payload
    }
}
