//
//  EditDefaultInfoTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class EditDefaultInfoTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let textField = TextField()
    
    var placeInfo: Place!
    
    var sectionType: EditProfileSection!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 13)
        self.contentView.addSubview(titleLabel)
        constrain(titleLabel, self.contentView) { label, view in
            label.left == view.left + 20
            label.top == view.top + 20
        }
        
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textField.font = UIFont(name: "Roboto-Regular", size: 15)
        self.contentView.addSubview(textField)
        constrain(textField, titleLabel, self.contentView) { textField, label, view in
            textField.left == view.left + 20
            textField.right == view.right - 20
            textField.top == label.bottom + 5
            textField.height == 40
            textField.bottom == view.bottom
        }
    }
    
    func configure(sectionType: EditProfileSection, data: String, place: Place) {
        self.sectionType = sectionType
        self.placeInfo = place
        
        titleLabel.text = sectionType.title
        textField.text = data
        textField.keyboardType = (sectionType == .phone) ? .numberPad : .default
    }
    
    @objc private func textFieldChanged() {
        switch sectionType {
        case .phone:
            placeInfo.phone = textField.text
        case .website:
            placeInfo.website = textField.text
        case .instagram:
            placeInfo.instagram = textField.text
        default:
            break
        }
    }
    
}

extension EditDefaultInfoTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if sectionType == .phone {
            let phonePattern = "+# (###) ###-##-##"
               
            if text.count == phonePattern.count && !string.isBackspace() { return false }
            textField.text = text.applyPatternOnNumbers(pattern: phonePattern, replacmentCharacter: "#")
        }
        
        return true
    }
}
