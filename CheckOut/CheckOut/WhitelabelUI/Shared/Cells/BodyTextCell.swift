//
//  BodyTextCell.swift
//  CheckOut
//
//  Created by Warrd Adlani on 27/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

class BodyTextCell: UITableViewCell {

    @IBOutlet weak var bodyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        bodyTextView.textContainerInset = UIEdgeInsets.zero
        bodyTextView.textContainer.lineFragmentPadding = 0
    }
}

extension BodyTextCell: CellPresentable {
    
    func setupCell(with configuration: CustomCell?, delegate: CellDelegate?) {
        
        bodyTextView.text = configuration?.content
    }
    
    func getInformationFromCell() -> CellData? {
        nil
    }
}
