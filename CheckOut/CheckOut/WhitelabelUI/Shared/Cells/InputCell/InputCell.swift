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
        
        guard let cellInputType = viewModel.cellInputType,
            let title = viewModel.content else { return }
        
        
        self.viewModel = viewModel
        
        inputField.placeholder = title
        inputField.text = viewModel.data
        inputField.isSecureTextEntry = cellInputType == .secure ? true : false
    }
    
    func getInformationFromCell() -> CellData? {
        
        let info = inputField?.text
        let information = CellData(information: info)
        
        return information
    }
}
