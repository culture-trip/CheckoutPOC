import Foundation

public class TableViewPresenter: TableViewPresenting {
    
    public var screen: Screen?
    weak public var view: TableViewing?
    public var title: String?
    
    required public init(screen: Screen?) {
       
        self.screen = screen
    }
    
    public func viewDidLoad() {
        
        
        if screen != nil, view != nil {
            
            updateView()
        }
    }
    
    public func updateView() {
        
        view?.viewReady()
    }
    
    /* Desc: setupCell
     *
     * In this method, the developer is expected to inject custom content i.e. from an API/BE service
     * which should override the content picked up from the json configuraion file
     */
    
    public func setupCell(_ cell: CellPresentable, item: Row?, indexPath: IndexPath?, delegate: CellDelegate?) {
    
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
        
        // At this point we need to inject API data via a condition
        let payload = Payload(content: item?.content)
                
        switch cellType {
            
        case .headerCell:
            viewModel = HeaderTextCellViewModel(item: item)
        case .inputCell:
            viewModel = InputCellViewModel(item: item)
        case .bodyTextCell:
            viewModel = BodyTextCellViewModel(payload: payload, item: item)
        case .singleActionButtonCell:
            viewModel = SingleActionButtonCellViewModel(item: item)
        case .subHeaderCell:
            viewModel = SubHeaderTextCellViewModel(item: item)
        case .paddingCell:
            viewModel = PaddingCellViewModel(item: item)
        }
        
        cell.setupCell(with: viewModel, delegate: delegate)
    }
    
    public func item(at indexPath: IndexPath) -> Row? {
        
        let section = indexPath.section
        let row = indexPath.row
        
        return screen?.sections?[section].rows?[row]
    }
}
