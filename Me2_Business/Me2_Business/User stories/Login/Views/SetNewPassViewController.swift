//
//  SetNewPassViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/23/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class SetNewPassViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: AttributedTextField!
    @IBOutlet weak var confirmPasswordTextField: AttributedTextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    let viewModel = SetNewPassViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
        
    private func configureViews() {
        confirmButton.disable()
        
        newPasswordTextField.delegate = self
        newPasswordTextField.rightViewAction = { [weak self] in
            self?.newPasswordTextField.isSecureTextEntry = !(self?.newPasswordTextField.isSecureTextEntry)!
        }
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.rightViewAction = { [weak self] in
            self?.confirmPasswordTextField.isSecureTextEntry = !(self?.confirmPasswordTextField.isSecureTextEntry)!
        }
    }

    private func checkPasswords() {
        if arePasswordsEqual() && isValidPassword() {
            confirmButton.enable()
        } else {
            confirmButton.disable()
        }
        
    }
    
    private func arePasswordsEqual() -> Bool {
        if newPasswordTextField.text != "" && confirmPasswordTextField.text != "" && newPasswordTextField.text != confirmPasswordTextField.text {
            errorLabel.text = "Пароли не совпадают"
            return false
        } else {
            errorLabel.text = ""
            return true
        }
    }
    
    private func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: newPasswordTextField.text!)
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        startLoader()
        
        viewModel.updatePass(with: newPasswordTextField.text!) { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(withStatus: .success, andText: "Пароль успешно изменен", completion: {
                    window.rootViewController = Storyboard.mainTabsViewController()
                })
            case .error:
                self?.stopLoader(withStatus: .fail, andText: message, completion: {
                    self?.errorLabel.text = message
                })
            case .fail:
                break
            }
        }
    }
}

extension SetNewPassViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isSecureTextEntry = true
        
        checkPasswords()
    }
}
