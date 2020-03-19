//
//  FeedbackViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class FeedbackViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    let viewModel = FeedbackViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTextView()
    }
    
    private func configureNavBar() {
//        navBar.tintColor = .black
//        setUpBackBarButton(for: navItem)
        
        navigationItem.title = "Обратная связь"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(sendFeedback))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
    }
    
    private func configureTextView() {
        textView.delegate = self
        textView.becomeFirstResponder()
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    }
    
    @objc private func sendFeedback() {
        viewModel.sendFeedback(withText: textView.text) { [weak self] (status, message) in
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

}

extension FeedbackViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let cursorPosition = textView.offset(from: textView.beginningOfDocument, to: textView.selectedTextRange!.start)
        
        if cursorPosition > 0 {
            textView.text = String(textView.text.prefix(cursorPosition))
            textView.textColor = .black
        } else {
            textView.text = "Мы всегда рады обратной связи, и ваше мнение очень важно для нас! Ваш отзыв поможет улучшить наше приложение и сделать его еще более удобным. Спасибо, что с нами!"
            textView.textColor = .lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }
}
