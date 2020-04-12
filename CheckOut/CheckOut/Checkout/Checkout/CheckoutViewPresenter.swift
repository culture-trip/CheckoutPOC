import Foundation

protocol CheckoutViewPresenting: AnyObject {
    
    func viewDidLoad()
    func viewReady()
    func setupCell(_ cell: CellPresentable, item: CustomCellItem?, indexPath: IndexPath?, delegate: CellDelegate?)
}

class CheckoutViewPresenter: CheckoutViewPresenting {
    
    func viewDidLoad() {
        
    }
    
    func viewReady() {
        
    }
    
    func setupCell(_ cell: CellPresentable, item: CustomCellItem?, indexPath: IndexPath?, delegate: CellDelegate?) {
        
        guard let cellType = item?.type else { return }
        
        var viewModel: CustomCellViewModel? = nil
        
        switch cellType {
            
        case .headerCell:
            viewModel = HeaderTextCellViewModel(item: item)
        case .inputCell:
            viewModel = InputCellViewModel(item: item)
        case .bodyTextCell:
            viewModel = BodyTextCellViewModel(item: item)
        case .singleActionButtonCell:
            viewModel = SingleActionButtonCellViewModel(item: item)
        case .subHeaderCell:
            viewModel = SubHeaderTextCellViewModel(item: item)
        case .paddingCell:
            viewModel = PaddingCellViewModel(item: item)
        }
        
        cell.setupCell(with: viewModel, delegate: delegate)
    }
}
