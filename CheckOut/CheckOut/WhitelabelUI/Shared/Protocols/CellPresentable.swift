import Foundation

public struct CellData {
    
    var information: String?
}

public protocol CellDelegate: AnyObject {}

public protocol CellPresentable: AnyObject {
    
    func getInformationFromCell() -> CellData?
    func setupCell(with viewModel: CustomCellViewModel?, delegate: CellDelegate?)
}

public protocol CustomCellViewModel {
    
    var customPayload: CustomPayload? { get set}
    var item: CustomCellItem? { get }
}
