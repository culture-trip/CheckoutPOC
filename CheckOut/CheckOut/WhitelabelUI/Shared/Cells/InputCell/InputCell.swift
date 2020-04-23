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
    
    private var viewModel: InputCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        inputField.delegate = self
    }
}

extension InputCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let result = textField.text {
        
            viewModel?.data = result + string
        }
        
        return true
    }
}

extension InputCell: CellPresentable {
    func setupCell(with viewModel: CellViewModel?, delegate: CellDelegate?) {
        
        guard let viewModel = viewModel as? InputCellViewModel else { return }
        
        self.viewModel = viewModel
        
        switch viewModel.cellInputType {
            
        case .normal: break
        case .name: inputField.textContentType = .name
        case .numerical: inputField.keyboardType = .numberPad
        case .address: inputField.textContentType = .fullStreetAddress
        case .email: inputField.textContentType = .emailAddress
        case .none:
            break
        }
        
        inputField.isSecureTextEntry = viewModel.isSecure
        inputField.text = viewModel.data
        
        guard let placeholder = viewModel.content else { return }
        inputField.placeholder = placeholder
    }
    
    func getInformationFromCell() -> CellData? {
        
        let info = inputField?.text
        let information = CellData(information: info)
        
        return information
    }
}
