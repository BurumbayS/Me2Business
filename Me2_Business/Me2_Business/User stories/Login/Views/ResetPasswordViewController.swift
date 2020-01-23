//
//  ResetPasswordViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/22/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var textField: AttributedTextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let viewModel = ResetPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureViews()
    }
    
    private func configureViews() {
        sendButton.disable()
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc private func textFieldChanged() {
        if textField.text != "" {
            sendButton.enable()
        } else {
            sendButton.disable()
        }
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        startLoader()
        
        viewModel.resetPassword(for: textField.text!) { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(completion: {
                    let vc = Storyboard.confirmCodeViewController() as! ConfirmCodeViewController
                    vc.viewModel = ConfirmCodeViewModel(activationID: self?.viewModel.phoneActivationID ?? 0, confirmationType: .onRegistrartion)
                    self?.navigationController?.pushViewController(vc, animated: true)
                })
            case .error:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            case .fail:
                self?.stopLoader(withStatus: .fail, andText: "Проблемы с интернетом. Попробуйте еще раз", completion: nil)
            }
            
        }
    }
}
