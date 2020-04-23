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
    var application: Application? { get set }
    var view: TableViewing? { get set }
    
    func viewDidLoad()
    func viewReady()
    func setupCell(_ cell: CellPresentable, item: Row?, indexPath: IndexPath?, delegate: CellDelegate?)
    func item(at indexPath: IndexPath) -> Row?
}
