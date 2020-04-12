//
//  SingleActionButtonCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

public protocol SubmitButtonDelegate: CellDelegate {
    
    func didTapSubmit()
}

class SingleActionButtonCell: UITableViewCell {

    @IBOutlet weak var submitButton: UIButton!
    
    fileprivate weak var delegate: SubmitButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    @IBAction func submit(_ sender: Any) {
        
        delegate?.didTapSubmit()
    }
}

extension SingleActionButtonCell: CellPresentable {
    
    func setupCell(with viewModel: CustomCellViewModel?, delegate: CellDelegate?) {
        
          guard let viewModel = viewModel as? SingleActionButtonCellViewModel else { return }
        
        if let delegate = delegate as? SubmitButtonDelegate {
            self.delegate = delegate
        }

        submitButton.setTitle(viewModel.content, for: .normal)
    }
    
    func getInformationFromCell() -> CellData? {
        return nil
    }
}
