//
//  PlaceTagTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/10/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class PlaceTagTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedCheck: UIImageView!
    
    func configure(title: String, selected: Bool) {
        titleLabel.text = title
        
        switch selected {
        case true:
            titleLabel.textColor = Color.blue
            selectedCheck.isHidden = false
        default:
            titleLabel.textColor = .black
            selectedCheck.isHidden = true
        }
    }

}
