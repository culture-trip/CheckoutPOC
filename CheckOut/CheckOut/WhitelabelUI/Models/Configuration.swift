import Foundation

public struct Items: Decodable {
    
    let items: [CustomCellItem]?
}

public struct Configuration: Decodable {
    
    let title: String?
    let sections: [Items]?
}
