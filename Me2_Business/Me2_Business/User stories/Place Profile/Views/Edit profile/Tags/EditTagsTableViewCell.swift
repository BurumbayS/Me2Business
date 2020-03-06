//
//  EditTagsTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

enum EditTagsCellType {
    case selectable
    case withPrice
    case toChoose
}

class EditTagsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pricaTextField: UITextField!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var enterPriceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(parameter: EditTagsParameters) {
        titleLabel.text = parameter.title
        
        checkImageView.isHidden = true
        
        switch parameter.cellType {
        case .withPrice:
            enterPriceView.isHidden = false
        default:
            enterPriceView.isHidden = true
        }
        
        switch parameter.cellType {
        case .toChoose:
            self.accessoryType = .disclosureIndicator
        default:
            self.accessoryType = .none
        }
    }

}
