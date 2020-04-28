//
//  InputCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell {

    @IBOutlet private weak var inputField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private var viewModel: InputCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        inputField.delegate = self
        inputField.layer.borderWidth = 1.0
        inputField.layer.cornerRadius = 4.0
        inputField.clipsToBounds = true
        inputField.layer.masksToBounds = true
        inputField.layer.borderColor = UIColor.clear.cgColor
        
        errorLabel.isHidden = true
    }
    
    fileprivate func resetCell() {
        
        showErrorState(false)
        viewModel?.setHighlighted(false)
    }
    
    
    fileprivate func showErrorState(_ isErrorState: Bool) {
        
        inputField.layer.borderColor = isErrorState ? UIColor.red.cgColor : UIColor.clear.cgColor
        errorLabel.isHidden = !isHighlighted
    }
}

extension InputCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let result = textField.text {
        
            var data = result + string
            
            if string == "" {
                
                data.removeLast()
            }
            
            let trimmed = data.trimmingCharacters(in: .whitespacesAndNewlines)
            
            viewModel?.data = trimmed.isEmpty ? nil : trimmed
        }
        
        resetCell()
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        viewModel?.data = nil
        
        resetCell()
            
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
        errorLabel.text = viewModel.errorTitle
        titleLabel.text = viewModel.title
        
        if let isHighlighted = viewModel.isHighlighted {
            
            showErrorState(isHighlighted)
        }
        
        guard let placeholder = viewModel.content else { return }
        inputField.placeholder = placeholder
    }
}
