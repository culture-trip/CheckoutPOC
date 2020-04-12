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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PaddingCell: CellPresentable {
    
    func getInformationFromCell() -> CellData? {
        return nil
    }
    
    func setupCell(with configuration: CustomCell?, delegate: CellDelegate?) {
        
        guard let configuration = configuration,
            let height = configuration.height?.getValue()
              else { return }
        
        paddingHeight.constant = CGFloat(height)
    }
}
