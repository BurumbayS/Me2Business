//
//  EventTagTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/31/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EventTagTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedIcon.isHidden = true
    }
    
    func configure(title: String, selected: Bool) {
        titleLabel.text = title
        titleLabel.textColor = (selected) ? Color.blue : .black
        selectedIcon.isHidden = !selected
    }
}
