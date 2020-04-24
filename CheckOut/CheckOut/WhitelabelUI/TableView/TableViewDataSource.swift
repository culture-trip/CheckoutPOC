import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    private weak var presenter: TableViewPresenting!
    
    init(presenter: TableViewPresenting) {
        
        self.presenter = presenter
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(with: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = presenter.item(at: indexPath),
            let cellIdentifier = row.type?.getIdentifier() else { return UITableViewCell() }
        
        guard let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CellPresentable else {
            return UITableViewCell()
        }
        
        presenter.setupCell(customCell, row: row, indexPath: indexPath)
        
        guard let cell = customCell as? UITableViewCell else {
            
            return UITableViewCell()
        }
        
        return cell
    }
}
