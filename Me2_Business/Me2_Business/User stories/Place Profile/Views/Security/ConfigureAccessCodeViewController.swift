//
//  ConfigureAccessCodeViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 4/1/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ConfigureAccessCodeViewController: UIViewController {

    
    @IBOutlet weak var activationView: UIView!
    @IBOutlet weak var activationSwitcher: UISwitch!
    @IBOutlet weak var changeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var changeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureViews()
    }
    
    private func configureViews() {
        activationSwitcher.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        
        changeView.addUnderline(with: .lightGray, and: CGSize(width: changeView.frame.width, height: changeView.frame.height))
        activationView.addUnderline(with: .lightGray, and: CGSize(width: activationView.frame.width, height: activationView.frame.height))
        
        changeView.isUserInteractionEnabled = true
        changeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeAccessCodePressed)))
        
        if let _ = UserDefaults().object(forKey: UserDefaultKeys.accessCode.rawValue) as? String {
            activationSwitcher.isOn = true
        } else {
            activationSwitcher.isOn = false
        }
        changeViewHeight.constant = (activationSwitcher.isOn) ? 60 : 0
    }
    
    @objc private func changeAccessCodePressed() {
    
        let vc = Storyboard.accessCodeViewController() as! AccessCodeViewController
        vc.viewModel = AccessCodeViewModel(type: .create)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func switchValueChanged() {
        changeViewHeight.constant = (activationSwitcher.isOn) ? 60 : 0
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
        if activationSwitcher.isOn {
            let vc = Storyboard.accessCodeViewController() as! AccessCodeViewController
            vc.viewModel = AccessCodeViewModel(type: .create)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            UserDefaults().removeObject(forKey: UserDefaultKeys.accessCode.rawValue)
        }
    }
}
