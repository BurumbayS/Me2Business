//
//  ApplicationFieldTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/9/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ApplicationFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: AttributedTextField!
    
    var fieldFilledCorrect: Dynamic<Bool>!
    var data: Dynamic<String>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
    }
    
    func configure(field: ApplicationField, data: Dynamic<String>, filledCorrect: Dynamic<Bool>) {
        self.fieldFilledCorrect = filledCorrect
        self.data = data
        
        titleLabel.text = field.title
        textField.placeholder = field.placeholder
        textField.keyboardType = field.keyboardStyle
    }
    
}

extension ApplicationFieldTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.keyboardType == .phonePad else { return true }
        guard let text = textField.text else { return false }
        
        if text.count < "+# (###) ###-##-##".count {
            textField.text = text.applyPatternOnNumbers(pattern: "+# (###) ###-##-##", replacmentCharacter: "#")
            return true
        }
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            return true
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        var isValid = false
        
        switch textField.keyboardType {
        case .phonePad:
            if text.count < "+# (###) ###-##-##".count {
                isValid = false
            } else {
                isValid = true
            }
        case .emailAddress:
            isValid = text.isValidEmail()
        default:
            isValid = text != ""
        }
        
        fieldFilledCorrect.value = isValid
        data.value = (isValid) ? text : ""
        textField.layer.borderColor = (isValid) ? Color.gray.cgColor : Color.red.cgColor
    }
}
