import Foundation

// MARK: - Model

public struct CustomCellItem: Decodable {
    
    let content: String?
    let height: PaddingType?
    let type: CustomCellType?
    let alignment: CellAlignmentType?
    let cellInputType: CellInputType?
    let action: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case content
        case height
        case type
        case alignment
        case cellInputType
        case action
    }
}

public struct CustomCellContent: Decodable {
    
    var content: String?
}

// MARK: Cell Types

public enum CustomCellType: String, CaseIterable, Decodable {
    
    case headerCell = "HeaderTextCell"
    case inputCell = "InputCell"
    case bodyTextCell = "BodyTextCell"
    case singleActionButtonCell = "SingleActionButtonCell"
    case paddingCell = "PaddingCell"
    case subHeaderCell = "SubHeaderTextCell"
}

// MARK: - Cell Input Types

public enum CellInputType: String, Decodable {
    
    case normal
    case name
    case address
    case email
    case secure
}

// MARK: - Cell Content Alignment types (not just for text)

public enum CellAlignmentType: String, Decodable {
    
    case left
    case right
    case center
}
