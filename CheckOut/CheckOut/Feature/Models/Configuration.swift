import Foundation

public enum CustomCellType: String, CaseIterable, Decodable {
    
    case titleCell = "TitleCell"
    case inputCell = "InputCell"
    case submitButtonCell = "SubmitButtonCell"
}

public enum CellInputType: String, Decodable {
    
    case normal
    case name
    case address
    case email
    case secure
}

public struct Configuration: Decodable {
    
    var title: String?
    var items: [CustomCell]?
}
