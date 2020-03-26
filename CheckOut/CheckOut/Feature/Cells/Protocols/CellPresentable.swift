import Foundation

public struct CellData {
    
    var information: String?
}

public protocol CellDelegate: AnyObject {}

public protocol CellPresentable: AnyObject {
    
    func getInformationFromCell() -> CellData?
    func setupCell(with configuration: CustomCell?, delegate: CellDelegate?)
}
