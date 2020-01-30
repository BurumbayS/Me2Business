//
//  AddEventPriceTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/30/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var fromPriceTextField: UITextField!
    @IBOutlet weak var toPriceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureTextFields()
    }
    
    private func configureTextFields() {
        fromPriceTextField.keyboardType = .numberPad
        toPriceTextField.keyboardType = .numberPad
    }
}
