//
//  SingleActionButtonCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class SingleActionButtonCell: UITableViewCell, Actionable {
    
    @IBOutlet weak var submitButton: UIButton!
    
    var action: Action?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        // Update button state for selection
    }
}

extension SingleActionButtonCell: CellPresentable {
    
    func setupCell(with viewModel: CustomCellViewModel?, delegate: CellDelegate?) {
        
        guard let viewModel = viewModel as? SingleActionButtonCellViewModel else { return }
        
        submitButton.setTitle(viewModel.content, for: .normal)
    }
    
    func getInformationFromCell() -> CellData? {
        return nil
    }
}
