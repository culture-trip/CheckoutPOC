//
//  CheckoutViewController.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

protocol CheckoutViewing: AnyObject {
    
    func viewReady()
}

import UIKit

class CheckoutViewController: UIViewController, CheckoutViewing {
    
    public var presenter: CheckoutViewPresenting = CheckoutViewPresenter()
    
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
        tableView.reloadData()
    }
}


extension CheckoutViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CheckoutViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.configuration?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.configuration?.sections?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        guard let item = presenter.configuration?.sections?[section].items?[indexPath.row] else { return UITableViewCell() }
        
        guard let cellIdentifier = item.type?.rawValue else { return UITableViewCell() }
        
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
}

extension CheckoutViewController: SubmitButtonDelegate {
    
    func didTapSubmit() {
        print("submit tapped")
        
        // Magic happens here where the information is collected using a generic struct
        
        for cell in cells {
            
            if let cell: CellPresentable = (cell as? CellPresentable) {
                print(cell.getInformationFromCell())
            }
        }
    }
}

