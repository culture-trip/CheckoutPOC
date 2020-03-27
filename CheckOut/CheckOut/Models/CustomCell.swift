import Foundation

public struct CustomCell: Decodable {
    
    let content: String?
    let height: CellHeightType?
    let type: CustomCellType?
    let alignment: CellAlignmentType?
    let cellInputType: CellInputType?
}

public enum CustomCellType: String, CaseIterable, Decodable {
    
    case headerCell = "HeaderTextCell"
    case inputCell = "InputCell"
    case bodyTextCell = "BodyTextCell"
    case singleActionButtonCell = "SingleActionButtonCell"
    case paddinfCell = "PaddingCell"
    case subHeaderCell = "SubHeaderTextCell"
}

public enum CellInputType: String, Decodable {
    
    case normal
    case name
    case address
    case email
    case secure
}

public enum CellAlignmentType: String, Decodable {
    
    case left
    case right
    case center
}

public enum CellHeightType: String, Decodable {
    
    case small
    case medium
    case large
    case xtraLarge
    
    func getValue() -> Double {
        switch self {
        case .small: return 4.0
        case .medium: return 8.0
        case .large: return 16.0
        case .xtraLarge: return 32.0
        }
    }
}
