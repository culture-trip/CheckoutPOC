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
    private var dataCallbackBlock: DataCallbackBlock?
    private lazy var viewModels: [ViewModel?] = {
        
        return [ViewModel]()
    }()
    
    required public init(screen: Screen?, view: TableViewing?, coordinator: Coordinator?, dataCallbackBlock: DataCallbackBlock?) {
        
        self.view = view
        self.coordinator = coordinator
        self.screen = screen
        self.dataCallbackBlock = dataCallbackBlock
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
                self?.updateData()
            })
        case .bodyTextCell:
            viewModel = BodyTextCellViewModel(row: row, payload: payload)
        case .singleActionButtonCell:
            viewModel = SingleActionButtonCellViewModel(row: row, payload: nil)
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
    
    // Sends data back in real time (Messaging pattern)
    
    private func updateData() {
        
        guard let callBack = dataCallbackBlock else { return }
        
        let dataList = collectData(from: viewModels)
        
        if let jsonData = JSONUtilities.buildJSONStringFromArray(dataList) {
                
            callBack(jsonData)
        }
    }
    
    private func collectData(from viewModels: [ViewModel?]?) -> ArrayOfDictionaries? {
        
        guard let viewModels = viewModels, viewModels.count > 0 else { return nil }
        
        var dataList = ArrayOfDictionaries()
        var index = 0
        
        for element in viewModels {
            
            if let viewModel = element?.viewModel as? Inputting {
                if let data = viewModel.data {
                    
                    var key = ""
                    
                    if let inputKey = viewModel.inputKey {
                        key = inputKey
                    } else {
                        key = "index_\(index)"
                    }
                    
                    dataList.append([key : data])
                    
                    index += 1
                }
            }
        }
        
        return dataList.count > 0 ? dataList : nil
    }
    
    public func item(at indexPath: IndexPath) -> Row? {
        
        let section = indexPath.section
        let row = indexPath.row
        
        return screen?.sections?[section].rows?[row]
    }
    
    // Sends data back when requested (Polling pattern)
    
    public func submit() {
        
        var scrollToTopIndex: IndexPath? = nil
        let dataList = collectData(from: viewModels)
        
        for element in viewModels {
            
            if let viewModel = element?.viewModel as? Inputting {
                
                if let isRequired = element?.viewModel.row?.isRequired, isRequired == true,
                    let indexPath = element?.indexPath, viewModel.data == nil {
                    
                    viewModel.setHighlighted(true)
                    if scrollToTopIndex == nil {
                        scrollToTopIndex = indexPath
                    }
                }
            }
        }
        
        if let scrollToTopIndex = scrollToTopIndex {
            
            view?.update(with: scrollToTopIndex)
            view?.scrollToIndexPath(scrollToTopIndex)
            
            return
        }
        
        if let jsonData = JSONUtilities.buildJSONStringFromArray(dataList) {
            
            coordinator?.returnedData?(jsonData)
        }
    }
}

extension TableViewPresenter: CellDelegate {}
