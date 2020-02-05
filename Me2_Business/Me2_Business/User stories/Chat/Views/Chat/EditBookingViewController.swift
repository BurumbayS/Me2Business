//
//  EditBookingViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/8/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditBookingViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var guestsNumberTextField: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    
    var pickedDate = ""
    var pickedNumberOfGuests = 0

    var booking: Booking!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDismissKeyboard()
        configureNavBar()
        configureViews()
    }
    
    private func configureNavBar() {
        navItem.title = "Изменить бронь"
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelEditing))
        navItem.leftBarButtonItem?.tintColor = Color.red
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(completeEditing))
        navItem.rightBarButtonItem?.isEnabled = false
        navItem.rightBarButtonItem?.tintColor = Color.blue
    }

    private func configureViews() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = .init(identifier: "ru")
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        dateTextField.inputView = datePicker
        
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .white
        picker.selectRow(3, inComponent: 0, animated: false)
        guestsNumberTextField.inputView = picker
    }
    
    @objc private func datePicked() {
        navItem.rightBarButtonItem?.isEnabled = true
        
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru")
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
        dateTextField.text = formatter.string(from: datePicker.date)
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        pickedDate = formatter.string(from: datePicker.date)
    }
    
    @objc private func cancelEditing() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func completeEditing() {
        self.view.endEditing(true)
        
        startLoader()
        
        booking.edit(dateAndTime: pickedDate, numOfGuests: pickedNumberOfGuests) { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(withStatus: .success, andText: "Бронь изменена") {
                    self?.dismiss(animated: true , completion: nil)
                }
            default:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
    }
}

extension EditBookingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        navItem.rightBarButtonItem?.isEnabled = true
        guestsNumberTextField.text = "\(row + 1)"
        pickedNumberOfGuests = row + 1
    }
}


