import UIKit


public class TableViewPresenter: TableViewPresenting {
    
    struct ViewModel {
        
        var viewModel: CellViewModel
        var indexPath: IndexPath
    }
    
    public var numberOfSections: Int {
        return screen?.sections?.count ?? 0
    }
    public var topContentInset: CGFloat {
        return screen?.topContentInset?.convertToCGFloat() ?? 0.0
    }
    public var bottomContentInset: CGFloat {
        return screen?.bottomContentInset?.convertToCGFloat() ?? 0.0
    }
    public var title: String?
    public var hasSeparators: Bool {
        
        return screen?.hasSeparators ?? false
    }
    
    private weak var view: TableViewing?
    private var screen: Screen?
    private weak var coordinator: Coordinator?
    private lazy var viewModels: [ViewModel?] = {
        
        return [ViewModel]()
    }()
    
    required public init(screen: Screen?, view: TableViewing?, coordinator: Coordinator?) {
        
        self.view = view
        self.coordinator = coordinator
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
    
    public func numberOfRows(with section: Int) -> Int {
        
        return screen?.sections?[section].rows?.count ?? 0
    }
    
    public func actionAtIndexPath(_ indexPath: IndexPath){
        
        if let action = screen?.sections?[indexPath.section].rows?[indexPath.row].action {
            if action.type == .submit {
                submit()
            }
        }
    }
    
    /* Desc: setupCell
     *
     * In this method, the developer is expected to inject custom content i.e. from an API/BE service
     * which should override the content picked up from the json configuraion file
     */
    
    public func setupCell(_ cell: CellPresentable, row: Row?, indexPath: IndexPath?) {
    
        guard let cellType = row?.type else { return }
        
        var viewModel: CellViewModel? = nil
        
        let payload = Payload(content: row?.content)
                
        switch cellType {
            
        case .headerCell:
            viewModel = HeaderTextCellViewModel(row: row, payload: nil)
        case .inputCell:
            viewModel = InputCellViewModel(row: row, payload: payload, actionBlock: { [weak self] in
                self?.view?.update(with: indexPath)
            })
        case .bodyTextCell:
            viewModel = BodyTextCellViewModel(row: row, payload: payload)
        case .singleActionButtonCell:
            viewModel = SingleActionButtonCellViewModel(row: row, payload: nil)
        case .subHeaderCell:
            viewModel = SubHeaderTextCellViewModel(row: row, payload: nil)
        case .paddingCell:
            viewModel = PaddingCellViewModel(row: row, payload: nil)
        case .separatorCell:
            return
        }
        
        if let viewModel = viewModel, let indexPath = indexPath {
            
            let result = ViewModel(viewModel: viewModel, indexPath: indexPath)
            
            if let exists = viewModels.filter({ $0?.indexPath == result.indexPath }).first {
                
                cell.setupCell(with: exists?.viewModel, delegate: self)
            } else {
                
                viewModels.append(result)
                
                cell.setupCell(with: result.viewModel, delegate: self)
            }
        }
    }
    
    public func item(at indexPath: IndexPath) -> Row? {
        
        let section = indexPath.section
        let row = indexPath.row
        
        return screen?.sections?[section].rows?[row]
    }
    
    public func submit() {
        
        var dataList = [String]()
        
        var scrollToTopIndex: IndexPath? = nil
        
        for element in viewModels {
            
            if let viewModel = element?.viewModel as? Inputting {
                if let data = viewModel.data {
                    
                    dataList.append(data)
                } else if let viewModel = element?.viewModel as? Inputting {
                    
                    if let isRequired = element?.viewModel.row?.isRequired, isRequired == true,
                        let indexPath = element?.indexPath {
                        
                        viewModel.setHighlighted(true)
                        if scrollToTopIndex == nil {
                            scrollToTopIndex = indexPath
                        }
                    }
                }
            }
        }
        
        if let scrollToTopIndex = scrollToTopIndex {
            view?.update(with: scrollToTopIndex)
            view?.scrollToIndexPath(scrollToTopIndex)
        }
                
        print(dataList) // Return info here
    }
}

extension TableViewPresenter: CellDelegate {}
