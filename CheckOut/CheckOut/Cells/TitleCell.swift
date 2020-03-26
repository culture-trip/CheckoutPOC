//
//  TitleCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

extension TitleCell: CellPresentable {
    func setupCell(with configuration: CellConfigutation?, delegate: CellDelegate?) { 
        
        titleLabel.text = configuration?.title
    }
    
    func getInformationFromCell() -> CellData? {
        nil
    }
}
