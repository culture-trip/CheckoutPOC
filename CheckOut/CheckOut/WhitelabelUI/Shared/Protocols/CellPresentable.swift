import Foundation

public struct CellData {
    
    var information: String?
}

public protocol CellDelegate: AnyObject {}

public protocol CellPresentable: AnyObject {
    
    func getInformationFromCell() -> CellData?
    func setupCell(with viewModel: CellViewModel?, delegate: CellDelegate?)
}

public protocol CellViewModel {
    
    var payload: Payload? { get set}
    var row: Row? { get }
    
    init(row: Row?, payload: Payload?)
}
