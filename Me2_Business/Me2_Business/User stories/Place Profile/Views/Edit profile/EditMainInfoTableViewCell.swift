//
//  EditMainInfoTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditMainInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionTextView.contentInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
    }
    
    func configure(place: Place) {
        titleLabel.text = place.name
        categoryLabel.text = place.category
        logoImageView.kf.setImage(with: URL(string: place.logo ?? ""), placeholder: UIImage(named: "default_place_logo"), options: [])
        descriptionTextView.text = place.description
    }
    
    @IBAction func chooseLogoPressed(_ sender: Any) {
    }
}
