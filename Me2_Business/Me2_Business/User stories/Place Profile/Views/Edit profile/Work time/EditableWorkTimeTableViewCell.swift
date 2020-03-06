 //
//  EditableWorkTimeTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditableWorkTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var daySelectedCheck: UIButton!
    @IBOutlet weak var timeFromTextField: UITextField!
    @IBOutlet weak var timeToTextField: UITextField!
    @IBOutlet weak var daynnightCheck: UIButton!
    @IBOutlet weak var daynnightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        daynnightCheck.layer.cornerRadius = 5
        daynnightCheck.layer.borderColor = Color.gray.cgColor
        daynnightCheck.layer.borderWidth = 1
        
        timeFromTextField.keyboardType = .numberPad
        timeToTextField.keyboardType = .numberPad
        
        //configure day'N'night label depend on screen width
        daynnightLabel.text = (UIScreen.main.bounds.width == 320) ? "24 ч." : "Круглосуточно"
    }

    func configure() {
        
    }
}
