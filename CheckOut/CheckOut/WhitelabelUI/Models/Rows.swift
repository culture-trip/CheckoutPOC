import Foundation

public struct Rows: Decodable {
    
    var rows: [Row]?
    
    public func updateValues(rows: [Row]?) -> Rows {
        
        return Rows(rows: rows ?? self.rows)
    }
}
