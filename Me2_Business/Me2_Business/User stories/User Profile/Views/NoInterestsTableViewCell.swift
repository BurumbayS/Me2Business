//
//  NoInterestsTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class NoInterestsTableViewCell: UITableViewCell {

    let placeHolderLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        placeHolderLabel.textColor = .darkGray
        placeHolderLabel.text = "Интересов пока нет"
        placeHolderLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        self.contentView.addSubview(placeHolderLabel)
        constrain(placeHolderLabel, self.contentView) { label, view in
            label.centerX == view.centerX
            label.bottom == view.bottom
            label.top == view.top + 25
            label.height == 20
        }
    }

}
