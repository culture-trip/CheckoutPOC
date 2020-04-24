import Foundation

public protocol CellDelegate: AnyObject {}

public protocol CellPresentable: AnyObject {
    
    func setupCell(with viewModel: CellViewModel?, delegate: CellDelegate?)
}

public protocol CellViewModel {
    
    var payload: Payload? { get set}
    var row: Row? { get }
    
    init(row: Row?, payload: Payload?)
}
