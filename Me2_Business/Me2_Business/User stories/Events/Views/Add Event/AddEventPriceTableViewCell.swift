//
//  AddEventPriceTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/30/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventPriceTableViewCell: AddEventTableViewCell {

    @IBOutlet weak var fromPriceTextField: UITextField!
    @IBOutlet weak var toPriceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureTextFields()
    }
    
    override func configure(data: EventData) {
        super.configure(data: data)
        
        if let price_min = eventData.price_min, let price_max = eventData.price_max {
            fromPriceTextField.text = String(price_min)
            toPriceTextField.text = String(price_max)
        }
    }
    
    private func configureTextFields() {
        fromPriceTextField.keyboardType = .numberPad
        toPriceTextField.keyboardType = .numberPad
        
        fromPriceTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        toPriceTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc private func textFieldChanged() {
        if fromPriceTextField.isFirstResponder {
            eventData.price_min = Int(fromPriceTextField.text!)
        }
        if toPriceTextField.isFirstResponder {
            eventData.price_max = Int(toPriceTextField.text!)
        }
    }
}
