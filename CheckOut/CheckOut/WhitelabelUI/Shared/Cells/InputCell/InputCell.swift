//
//  InputCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell {

    @IBOutlet weak var inputField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

extension InputCell: CellPresentable {
    func setupCell(with viewModel: CustomCellViewModel?, delegate: CellDelegate?) {
        
        guard let viewModel = viewModel as? InputCellViewModel else { return }
        
        guard let cellInputType = viewModel.cellInputType,
            let title = viewModel.content else { return }
        
        inputField.placeholder = title
        inputField.isSecureTextEntry = cellInputType == .secure ? true : false
    }
    
    func getInformationFromCell() -> CellData? {
        
        let info = inputField?.text
        let information = CellData(information: info)
        
        return information
    }
}
