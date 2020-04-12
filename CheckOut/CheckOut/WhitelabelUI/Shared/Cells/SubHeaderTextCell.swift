//
//  SubHeaderTextCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 27/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class SubHeaderTextCell: UITableViewCell {
    
    @IBOutlet private weak var subheaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

extension SubHeaderTextCell: CellPresentable {
    
    func setupCell(with configuration: CustomCell?, delegate: CellDelegate?) {
        
        subheaderLabel.text = configuration?.content
    }
    
    func getInformationFromCell() -> CellData? {
        nil
    }
}