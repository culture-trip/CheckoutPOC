import Foundation

public struct Rows: Decodable {
    
    let rows: [Row]?
    
    public func updateValues(rows: [Row]?) -> Rows {
        
        return Rows(rows: rows ?? self.rows)
    }
}
