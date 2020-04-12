import Foundation

protocol CheckoutViewPresenting: AnyObject {
    
    var title: String? { get set }
    var configuration: Configuration? { get set }
    var view: CheckoutViewing? { get set }
    
    func viewDidLoad()
    func viewReady()
    func setupCell(_ cell: CellPresentable, item: CustomCellItem?, indexPath: IndexPath?, delegate: CellDelegate?)
}

class CheckoutViewPresenter: CheckoutViewPresenting {
    
    weak var view: CheckoutViewing?
    public var title: String?
    public var configuration: Configuration?
    
    func viewDidLoad() {
        
        ConfigurationLoader.parseConfiguration(with: "experiences_checkout") { result, error  in
            
            DispatchQueue.main.async { [weak self] in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self?.title = self?.configuration?.title
                    self?.configuration = result
                    self?.viewReady()
                }
            }
        }
    }
    
    func viewReady() {
        
        view?.viewReady()
    }
    
    /* Desc: setupCell
     *
     * In this method, the developer is expected to inject custom content i.e. from an API/BE service
     * which should override the content picked up from the json configuraion file
     */
    
    func setupCell(_ cell: CellPresentable, item: CustomCellItem?, indexPath: IndexPath?, delegate: CellDelegate?) {
    
        guard let cellType = item?.type else { return }
        
        var viewModel: CustomCellViewModel? = nil
        
        // Custom payload example extracted from an api model (REDACTED)
        
        /* Current problem is synchronizing API data with cells (PRESENT) */
        
        /* Idea's to solve data sync ... :
         * - Pass a customized presenter.
         * - Pass index paths for content.
         * - View Controller extracts and passes model and indexes.
         */
        
        let customPayload = CustomPayload(content: "Custom Header from API - Please enter address below as per supplied", title: nil)
        
        switch cellType {
            
        case .headerCell:
            viewModel = HeaderTextCellViewModel(item: item)
        case .inputCell:
            viewModel = InputCellViewModel(item: item)
        case .bodyTextCell:
            viewModel = BodyTextCellViewModel(customPayload: customPayload, item: item)
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
