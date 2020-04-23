//
//  PaddingCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 27/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class PaddingCell: UITableViewCell {

    @IBOutlet private weak var paddingHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

extension PaddingCell: CellPresentable {
    
    func setupCell(with viewModel: CellViewModel?, delegate: CellDelegate?) {
        
        guard let viewModel = viewModel as? PaddingCellViewModel,
            let height = viewModel.height?.getValue()
              else { return }
        
        paddingHeight.constant = CGFloat(height)
    }
    
    func getInformationFromCell() -> CellData? {
        return nil
    }
}
