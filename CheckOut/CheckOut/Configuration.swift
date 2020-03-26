import Foundation

public enum CellType: String, CaseIterable, Decodable {
    
    case titleCell = "TitleCell"
    case inputCell = "InputCell"
    case submitButtonCell = "SubmitButtonCell"
}

public enum InputType: String, Decodable {
    
    case normal
    case name
    case address
    case email
    case secure
}

public struct CellConfigutation: Decodable {
    
    var title: String?
    var type: CellType?
    var inputType: InputType?
}

public struct Configuration: Decodable {
    
    var title: String?
    var items: [CellConfigutation]?
}
