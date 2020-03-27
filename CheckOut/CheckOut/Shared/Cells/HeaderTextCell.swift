//
//  HeaderCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class HeaderTextCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

extension HeaderTextCell: CellPresentable {
    func setupCell(with configuration: CustomCell?, delegate: CellDelegate?) { 
        if let aligntment = configuration?.alignment {
            
            switch aligntment {
            case .left:
                titleLabel.textAlignment = .left
            case .right:
                titleLabel.textAlignment = .right
            case .center:
                titleLabel.textAlignment = .center
            }
        }
        
        titleLabel.text = configuration?.content
    }
    
    func getInformationFromCell() -> CellData? {
        nil
    }
}
