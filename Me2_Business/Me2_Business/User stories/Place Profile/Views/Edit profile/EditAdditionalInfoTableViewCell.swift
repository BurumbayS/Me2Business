//
//  EditAdditionalInfoTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class EditAdditionalInfoTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        self.contentView.addSubview(titleLabel)
        constrain(titleLabel, self.contentView) { label, view in
            label.left == view.left + 20
            label.height == 20
            label.top == view.top + 20
            label.bottom == view.bottom - 20
        }
        
        let underline = UIView()
        underline.backgroundColor = Color.lightGray
        self.contentView.addSubview(underline)
        constrain(underline, self.contentView) { line, view in
            line.left == view.left
            line.right == view.right
            line.bottom == view.bottom
            line.height == 1
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
        
        self.accessoryType = .disclosureIndicator
    }
}
