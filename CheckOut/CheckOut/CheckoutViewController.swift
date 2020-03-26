//
//  CheckoutViewController.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var cells: [UITableViewCell] = { [UITableViewCell]() }()
    
    private var configuration: Configuration? {
        didSet {
            titleLabel.text = configuration?.title
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TitleCell.nib(), forCellReuseIdentifier: TitleCell.className)
        tableView.register(InputCell.nib(), forCellReuseIdentifier: InputCell.className)
        tableView.register(SubmitButtonCell.nib(), forCellReuseIdentifier: SubmitButtonCell.className)
        
        tableView.tableFooterView = UIView()
        
        parseConfiguration(with: "experiences_checkout") { result in
            DispatchQueue.main.async { [unowned self] in
                self.configuration = result
            }
        }
    }
    
    func parseConfiguration(with name: String, completion: @escaping (Configuration?)->()) {
        
        let queue = DispatchQueue(label: "configuration-loader-queue")
        var config: Configuration? = nil
        
        queue.async {
            if let path = Bundle.main.path(forResource: name, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    
                    print(jsonResult)
                    
                    config = try JSONDecoder().decode(Configuration.self, from: data)
                    completion(config)
                    print(config ?? "failed")
                } catch {
                    completion(nil)
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
        if !(cells.contains(cell) ?? false) {
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

