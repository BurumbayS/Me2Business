//
//  AddEventMainInfoTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventMainInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = Color.gray.cgColor
        descriptionTextView.layer.cornerRadius = 5
    }
    
    @IBAction func addWallpaperPressed(_ sender: Any) {
    }
}
