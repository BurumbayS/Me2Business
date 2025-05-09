//
//  AddEventTimeTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/30/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventTimeTableViewCell: AddEventTableViewCell {

    @IBOutlet weak var fromTimeTextField: UITextField!
    @IBOutlet weak var toTimeTextField: UITextField!
    
    let timePicker = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureTextFields()
    }
    
    override func configure(data: EventData) {
        super.configure(data: data)
        
        fromTimeTextField.text = String(eventData.time_start?.prefix(5) ?? "")
        toTimeTextField.text = String(eventData.time_end?.prefix(5) ?? "")
    }
    
    private func configureTextFields() {
        timePicker.datePickerMode = .time
        timePicker.locale = .init(identifier: "ru")
        timePicker.backgroundColor = .white
        timePicker.addTarget(self, action: #selector(timePicked), for: .valueChanged)
        
        fromTimeTextField.inputView = timePicker
        toTimeTextField.inputView = timePicker
    }
    
    @objc private func timePicked() {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru")
        formatter.dateFormat = "HH:mm"
        
        if fromTimeTextField.isFirstResponder {
            fromTimeTextField.text = formatter.string(from: timePicker.date)
            eventData.time_start = formatter.string(from: timePicker.date)
        }
        if toTimeTextField.isFirstResponder {
            toTimeTextField.text = formatter.string(from: timePicker.date)
            eventData.time_end = formatter.string(from: timePicker.date)
        }
    }
}
