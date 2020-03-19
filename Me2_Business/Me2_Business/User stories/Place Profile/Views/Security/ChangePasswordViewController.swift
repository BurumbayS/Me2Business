//
//  ChangePasswordViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var currentPasswordTextField: AttributedTextField!
    @IBOutlet weak var newPasswordTextField: AttributedTextField!
    @IBOutlet weak var confirmNewPasswordTextField: AttributedTextField!
    
    let viewModel = ChangePasswordViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Изменить пароль"
        
        configureTextFields()
    }

    private func configureTextFields() {
        configure(textField: currentPasswordTextField)
        configure(textField: newPasswordTextField)
        configure(textField: confirmNewPasswordTextField)
    }
    
    private func configure(textField: AttributedTextField) {
        textField.delegate = self
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Color.gray.cgColor
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.rightViewAction = {
            textField.isSecureTextEntry = !(textField.isSecureTextEntry)
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard fieldsAreCorrect() else { return }
        
        viewModel.updatePassword(password:currentPasswordTextField.text!, with: newPasswordTextField.text!) { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.navigationController?.popViewController(animated: true)
            case .error:
                break
            case .fail:
                break
            }
        }
    }
    
    private func fieldsAreCorrect() -> Bool {
        if currentPasswordTextField.text == "" {
            currentPasswordTextField.layer.borderColor = Color.red.cgColor
            return false
        }
        if newPasswordTextField.text == "" {
            newPasswordTextField.layer.borderColor = Color.red.cgColor
            return false
        }
        if confirmNewPasswordTextField.text == "" {
            confirmNewPasswordTextField.layer.borderColor = Color.red.cgColor
            return false
        }
        
        if newPasswordTextField.text != confirmNewPasswordTextField.text {
            return false
        }
        
        return true
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Color.gray.cgColor
    }
}
