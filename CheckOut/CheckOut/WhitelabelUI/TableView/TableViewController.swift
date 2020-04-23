import UIKit

class TableViewController: UIViewController, TableViewing {
    
    public var presenter: TableViewPresenting! {
        
        didSet {
            tableViewDataSource = TableViewDataSource(presenter: presenter)
            tableViewDelegate = TableViewDelegate(presenter: presenter)
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var tableViewDataSource: TableViewDataSource?
    private var tableViewDelegate: TableViewDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        presenter.viewDidLoad()
    }
    
    private func setupTableView() {
        
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        tableView.register(HeaderTextCell.nib(), forCellReuseIdentifier: HeaderTextCell.className)
        tableView.register(InputCell.nib(), forCellReuseIdentifier: InputCell.className)
        tableView.register(BodyTextCell.nib(), forCellReuseIdentifier: BodyTextCell.className)
        tableView.register(SingleActionButtonCell.nib(), forCellReuseIdentifier: SingleActionButtonCell.className)
        tableView.register(PaddingCell.nib(), forCellReuseIdentifier: PaddingCell.className)
        tableView.register(SubHeaderTextCell.nib(), forCellReuseIdentifier: SubHeaderTextCell.className)
        
        tableView.tableFooterView = UIView()
    }
    
    public func viewReady() {
        
        title = presenter.title
        var contentInset = tableView.contentInset
        
        contentInset.top = presenter.topContentInset
        contentInset.bottom = presenter.bottomContentInset
        
        tableView.contentInset = contentInset
        
        tableView.reloadData()
    }
    
//    private func submit() {
//        print("submit tapped")
//
//        // Magic happens here where the information is collected using a generic struct
//
//        for cell in cells {
//
//            if let cell: CellPresentable = (cell as? CellPresentable) {
//                print(cell.getInformationFromCell())
//            }
//        }
//    }
}
