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
    func setupCell(with configuration: CustomCell?, delegate: CellDelegate?) {
        
        if let delegate = delegate as? SubmitButtonDelegate {
            self.delegate = delegate
        }

        submitButton.setTitle(configuration?.content, for: .normal)
    }
    
    func getInformationFromCell() -> CellData? {
        return nil
    }
}
