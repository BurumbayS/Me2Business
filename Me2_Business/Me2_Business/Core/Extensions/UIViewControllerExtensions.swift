//
//  UIViewControllerExtensions.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

let window = UIApplication.shared.keyWindow!
let loader = Storyboard.loaderViewController() as! LoaderViewController

enum ActionSheetTextAlignment: Int {
    case left = 0
    case center = 1
    case right = 2
}

extension UIViewController {
    func addActionSheet(titles: [String], images: [String] = [], actions: [VoidBlock?], styles: [UIAlertAction.Style], tintColor: UIColor = Color.blue, textAlignment: ActionSheetTextAlignment = .center) {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = tintColor
        
        for i in 0..<titles.count {
            let action = UIAlertAction(title: titles[i], style: styles[i]) { (action) in
                actions[i]?()
            }
            
            if images.count > 0 {
                action.setValue(UIImage(named: images[i]), forKey: "image")
            }
            
            action.setValue(textAlignment.rawValue, forKey: "titleTextAlignment")
            
            actionSheetController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
            actionSheetController.dismiss(animated: true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func setUpBackBarButton(for navItem: UINavigationItem) {
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button"), style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    func removeBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc func dismissSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    func showDefaultAlert(title: String, message: String, doneTitle: String = "Ок", cancelTitle: String = "Отмена", doneAction: VoidBlock?, onCancel: VoidBlock? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.setMessage(font: UIFont(name: "Roboto-Regular", size: 15), color: .black)
        alert.addAction(UIAlertAction(title: doneTitle, style: .default, handler: { (alert) in
            doneAction?()
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .destructive, handler: { (alert) in
            onCancel?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showInfoAlert(title: String, message: String, onAccept: VoidBlock?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.setMessage(font: UIFont(name: "Roboto-Regular", size: 15), color: .black)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (alert) in
            onAccept?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func safeAreaSize() -> CGSize {
        var height = CGFloat()
        
        if let tabBarHeight = self.tabBarController?.tabBar.frame.height {
            height = tabBarHeight + (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        } else {
            height = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - height)
    }
    
    func addDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func startLoader() {
        loader.modalPresentationStyle = .custom
        present(loader, animated: false, completion: nil)
    }
    
    func stopLoader(withStatus status: LoadingStatus = .dismiss, andText text: String = "", completion: VoidBlock? = nil) {
        loader.loadingCompletionHandler = completion
        
        switch status {
        case .success:
            loader.succes(withMessage: text)
        case .fail:
            loader.fail(withMessage: text)
        default:
            loader.dismiss()
        }
    }
    
    func makeNavBarTransparent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func makeNavBarVisible() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .white
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
