//
//  LoginViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: AttributedTextField!
    @IBOutlet weak var passwordTextField: AttributedTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        addDismissKeyboard()
        configureViews()
    }
    
    private func configureViews() {
        disableLoginButton()
        
        passwordTextField.delegate = self
        passwordTextField.tag = 2
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightViewAction = { [weak self] in
            self?.passwordTextField.isSecureTextEntry = !(self?.passwordTextField.isSecureTextEntry)!
        }
        
        emailTextField.tag = 1
        emailTextField.delegate = self
        emailTextField.isSecureTextEntry = false
    }
    
    private func enableLoginButton() {
        loginButton.isEnabled = true
        loginButton.alpha = 1.0
    }
    private func disableLoginButton() {
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
    }
    
    private func showError(with message: String) {
        errorLabel.text = message
        emailTextField.layer.borderColor = Color.red.cgColor
        emailTextField.textColor = Color.red
        passwordTextField.layer.borderColor = Color.red.cgColor
        passwordTextField.textColor = Color.red
    }
    
    private func hideError() {
        errorLabel.text = ""
        emailTextField.layer.borderColor = Color.gray.cgColor
        emailTextField.textColor = .black
        passwordTextField.layer.borderColor = Color.gray.cgColor
        passwordTextField.textColor = .black
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        viewModel.signIn(with: emailTextField.text!, and: passwordTextField.text!) { [weak self] (status, message) in
            switch status {
            case .ok:
                window.rootViewController = Storyboard.mainTabsViewController()
            case .error, .fail:
                self?.showError(with: message)
            }
        }
    }
    
    @IBAction func sendApplicationPressed(_ sender: Any) {
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        //check for password text field by tag
        textField.isSecureTextEntry = (textField.tag == 2) ? true : false
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            enableLoginButton()
        } else {
            disableLoginButton()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if errorLabel.text != "" {
            hideError()
        }
    }
}

