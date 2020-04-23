import UIKit

class TableViewController: UIViewController, TableViewing {
    
    public var presenter: TableViewPresenting!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var cells: [UITableViewCell] = { [UITableViewCell]() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HeaderTextCell.nib(), forCellReuseIdentifier: HeaderTextCell.className)
        tableView.register(InputCell.nib(), forCellReuseIdentifier: InputCell.className)
        tableView.register(BodyTextCell.nib(), forCellReuseIdentifier: BodyTextCell.className)
        tableView.register(SingleActionButtonCell.nib(), forCellReuseIdentifier: SingleActionButtonCell.className)
        tableView.register(PaddingCell.nib(), forCellReuseIdentifier: PaddingCell.className)
        tableView.register(SubHeaderTextCell.nib(), forCellReuseIdentifier: SubHeaderTextCell.className)
        
        tableView.tableFooterView = UIView()
        
        presenter.view = self
        
        presenter.viewDidLoad()
    }
    
    public func viewReady() {
        
        title = presenter.title
        var contentInset = tableView.contentInset
        
        contentInset.top = CGFloat(presenter.application?.screens?.first?.topContentInset?.getValue() ?? 0.0)
        contentInset.bottom = CGFloat(presenter.application?.screens?.first?.bottomContentInset?.getValue() ?? 0.0)
        
        tableView.contentInset = contentInset
        
        tableView.reloadData()
    }
}


extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.application?.screens?.first?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.application?.screens?.first?.sections?[section].rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let item = presenter.item(at: indexPath),
              let cellIdentifier = item.type?.rawValue else { return UITableViewCell() }
        
        guard let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CellPresentable else {
            return UITableViewCell()
        }

        presenter.setupCell(customCell, item: item, indexPath: indexPath, delegate: self)
        
        guard let cell = customCell as? UITableViewCell else {
            
            return UITableViewCell()
        }
        
        // Store cells to collect their relevant data from the array
        if !cells.contains(cell) {
            cells.append(cell)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let section = presenter.application?.screens?.first?.sections?[indexPath.section] {
            if let action = section.rows?[indexPath.row].action?.type {
                if action == .submit {
                    submit()
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
        }
    }
    
    func submit() {
        print("submit tapped")
        
        // Magic happens here where the information is collected using a generic struct
        
        for cell in cells {
            
            if let cell: CellPresentable = (cell as? CellPresentable) {
                print(cell.getInformationFromCell())
            }
        }
    }
}

extension TableViewController: CellDelegate {}

