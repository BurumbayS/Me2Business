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
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        addDismissKeyboard()
        configureViews()
    }
    
    private func configureViews() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightViewAction = { [weak self] in
            self?.passwordTextField.isSecureTextEntry = !(self?.passwordTextField.isSecureTextEntry)!
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
    }
    
    @IBAction func loginPressed(_ sender: Any) {
    }
    
    @IBAction func sendApplicationPressed(_ sender: Any) {
    }
}
