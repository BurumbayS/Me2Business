//
//  AddEventDateTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventDateTableViewCell: AddEventTableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    let dates = [DateType.once, .everyday, .weekdays, .weekends]
    var selectedDateIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        for (i, item) in stackView.subviews.enumerated() {
            if let checkbox = item as? Checkbox {
                checkbox.checkFlag.image = UIImage(named: "empty_checkbox")
                checkbox.titleLabel.text = dates[i].title
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(selectDateType(_:)))
                tap.accessibilityValue = "\(i)"
                checkbox.isUserInteractionEnabled = true
                checkbox.addGestureRecognizer(tap)
            }
        }
        
        configureTextFields()
    }
    
    private func configureTextFields() {
        datePicker.datePickerMode = .date
        datePicker.locale = .init(identifier: "ru")
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        
        fromDateTextField.inputView = datePicker
        toDateTextField.inputView = datePicker
    }
    
    @objc private func datePicked() {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru")
        formatter.dateFormat = "dd MMM yyyy"
        
        if fromDateTextField.isFirstResponder {
            fromDateTextField.text = formatter.string(from: datePicker.date)
        }
        if toDateTextField.isFirstResponder {
            toDateTextField.text = formatter.string(from: datePicker.date)
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        if fromDateTextField.isFirstResponder {
            eventData.start = formatter.string(from: datePicker.date)
        }
        if toDateTextField.isFirstResponder {
            eventData.end = formatter.string(from: datePicker.date)
        }
    }
    
    @objc private func selectDateType(_ sender: UITapGestureRecognizer) {
        guard let prevSelectedCheckbox = stackView.subviews[selectedDateIndex] as? Checkbox else { return }
        prevSelectedCheckbox.unselect()
        
        let selectedIndex = Int(sender.accessibilityValue!)
        guard let selectedCheckbox = stackView.subviews[selectedIndex!] as? Checkbox else { return }
        selectedCheckbox.select()
        
        selectedDateIndex = selectedIndex!
        eventData.dateType = dates[selectedDateIndex]
    }
}
