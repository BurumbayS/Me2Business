//
//  ComplaintReasonTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ComplaintReasonTableViewCell: UITableViewCell {

    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var selectedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedIcon.isHidden = true
    }
    
    func configure(text: String, selected: Bool) {
        reasonLabel.text = text
        reasonLabel.textColor = (selected) ? Color.blue : .black
        selectedIcon.isHidden = !selected
    }
}
