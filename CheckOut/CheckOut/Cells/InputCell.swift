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
    func setupCell(with configuration: CellConfigutation?, delegate: CellDelegate?) { 
        
        guard let inputType = configuration?.inputType,
            let title = configuration?.title else { return }
        
        inputField.placeholder = title
        inputField.isSecureTextEntry = inputType == .secure ? true : false
    }
    
    func getInformationFromCell() -> CellData? {
        
        let info = inputField?.text
        let information = CellData(information: info)
        
        return information
    }
}
