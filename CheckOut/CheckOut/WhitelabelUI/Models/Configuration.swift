import Foundation

public struct Configuration: Decodable {
    
    let title: String?
    let items: [CustomCellItem]?
}
