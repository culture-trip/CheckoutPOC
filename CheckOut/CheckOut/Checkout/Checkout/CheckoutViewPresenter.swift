import Foundation

protocol CheckoutViewPresenting: AnyObject {
    
    var title: String? { get set }
    var application: Application? { get set }
    var view: CheckoutViewing? { get set }
    
    func viewDidLoad()
    func viewReady()
    func setupCell(_ cell: CellPresentable, item: Row?, indexPath: IndexPath?, delegate: CellDelegate?)
    func item(at indexPath: IndexPath) -> Row?
}

class CheckoutViewPresenter: CheckoutViewPresenting {
    
    weak var view: CheckoutViewing?
    public var title: String?
    public var application: Application?
    
    private let jsonFile = "experiences_checkout"
    
    func viewDidLoad() {
        
        ApplicationLoader.parseConfiguration(with: jsonFile) { result, error  in
            
            DispatchQueue.main.async { [weak self] in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self?.title = self?.application?.screens?.first?.title
                    self?.application = result
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
    
    func setupCell(_ cell: CellPresentable, item: Row?, indexPath: IndexPath?, delegate: CellDelegate?) {
    
        guard let cellType = item?.type else { return }
        
        var viewModel: CustomCellViewModel? = nil
        
        // Custom payload example extracted from an api model (REDACTED)
        
        /* Current problem is synchronizing API data with cells (PRESENT) */
        
        /* Idea's to solve data sync ... :
         * - Pass a customized presenter.
         * - Pass index paths for content.
         * - View Controller extracts and passes model and indexes.
         * - Worker class creates key-value pairs
         * - Add "customContentKey" to json for extracting and mapping
         */
        
        let examplePayload = Payload(content: "API Test content")
                
        switch cellType {
            
        case .headerCell:
            viewModel = HeaderTextCellViewModel(item: item)
        case .inputCell:
            viewModel = InputCellViewModel(item: item)
        case .bodyTextCell:
            viewModel = BodyTextCellViewModel(payload: examplePayload, item: item)
        case .singleActionButtonCell:
            viewModel = SingleActionButtonCellViewModel(item: item)
        case .subHeaderCell:
            viewModel = SubHeaderTextCellViewModel(item: item)
        case .paddingCell:
            viewModel = PaddingCellViewModel(item: item)
        }
        
        cell.setupCell(with: viewModel, delegate: delegate)
    }
    
    func item(at indexPath: IndexPath) -> Row? {
        
        let section = indexPath.section
        let row = indexPath.row
        
        return application?.screens?.first?.sections?[section].rows?[row]
    }
}
