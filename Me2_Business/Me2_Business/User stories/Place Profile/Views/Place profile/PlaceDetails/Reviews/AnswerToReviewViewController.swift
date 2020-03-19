//
//  AnswerToReviewViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/13/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AnswerToReviewViewController: UIViewController {

    @IBOutlet weak var answerTextView: UITextView!
    
    var viewModel: AnswerToReviewViewModel!
    
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
        
        navigationItem.title = "Ответить на отзыв"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(answerToReview))
        navigationItem.rightBarButtonItem?.tintColor = Color.blue
    }
    
    private func configureTextView() {
        answerTextView.delegate = self
        answerTextView.becomeFirstResponder()
        answerTextView.selectedTextRange = answerTextView.textRange(from: answerTextView.beginningOfDocument, to: answerTextView.beginningOfDocument)
    }
    
    @objc private func answerToReview() {
        self.view.endEditing(true)
        
        startLoader()
        viewModel.answerToReview(withText: answerTextView.text) { [weak self] (status, message) in
            switch status {
            case .ok:
                self?.stopLoader(withStatus: .success, andText: "Вы ответили на отзыв", completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            case .error, .fail:
                self?.stopLoader(withStatus: .fail, andText: message, completion: nil)
            }
        }
    }

}

extension AnswerToReviewViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let cursorPosition = textView.offset(from: textView.beginningOfDocument, to: textView.selectedTextRange!.start)
        
        if cursorPosition > 0 {
            textView.text = String(textView.text.prefix(cursorPosition))
            textView.textColor = .black
        } else {
            textView.text = "Ваш отзыв"
            textView.textColor = .lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }
}
