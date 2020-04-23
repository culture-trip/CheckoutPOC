//
//  TableViewProtocols.swift
//  CheckOut
//
//  Created by Warrd Adlani on 23/04/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import Foundation

public protocol TableViewing: AnyObject {
    
    var presenter: TableViewPresenting! { get set }
    
    func viewReady()
}

public protocol TableViewPresenting: AnyObject {
    
    var title: String? { get set }
    var view: TableViewing? { get set }
    var screen: Screen? { get set }
    
    func viewDidLoad()
    func updateView()
    func setupCell(_ cell: CellPresentable, item: Row?, indexPath: IndexPath?, delegate: CellDelegate?)
    func item(at indexPath: IndexPath) -> Row?
    
     init(screen: Screen?)
}
