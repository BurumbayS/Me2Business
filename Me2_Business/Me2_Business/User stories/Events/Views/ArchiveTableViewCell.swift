//
//  ArchiveTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ArchiveTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
            
        addUnderline(with: Color.gray, and: CGSize(width: UIScreen.main.bounds.width, height: 48))
    }
    
}
