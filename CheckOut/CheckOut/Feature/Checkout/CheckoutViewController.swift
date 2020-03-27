//
//  CheckoutViewController.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var cells: [UITableViewCell] = { [UITableViewCell]() }()
    
    private var configuration: Configuration? {
        didSet {
            title = configuration?.title
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HeaderCell.nib(), forCellReuseIdentifier: HeaderCell.className)
        tableView.register(InputCell.nib(), forCellReuseIdentifier: InputCell.className)
        tableView.register(BodyTextCell.nib(), forCellReuseIdentifier: BodyTextCell.className)
        tableView.register(SubmitButtonCell.nib(), forCellReuseIdentifier: SubmitButtonCell.className)
        tableView.register(PaddingCell.nib(), forCellReuseIdentifier: PaddingCell.className)
        tableView.register(SubheaderCell.nib(), forCellReuseIdentifier: SubheaderCell.className)
        
        tableView.tableFooterView = UIView()
        
        ConfigurationLoader.parseConfiguration(with: "experiences_checkout") { result, error  in
            DispatchQueue.main.async { [unowned self] in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.configuration = result
                }
            }
        }
    }
}


extension CheckoutViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CheckoutViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = configuration?.items?[indexPath.row] else { return UITableViewCell() }
        
        guard let cellIdentifier = item.type?.rawValue else { return UITableViewCell() }
        
        guard let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CellPresentable else {
            return UITableViewCell()
        }
        
        customCell.setupCell(with: item, delegate: self)
        
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

