//
//  AddEventMainInfoTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class AddEventMainInfoTableViewCell: AddEventTableViewCell {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = Color.gray.cgColor
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.delegate = self
        
        titleTextField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
    }
    
    @objc private func titleChanged() {
        eventData.name = titleTextField.text!
    }
    
    @IBAction func addWallpaperPressed(_ sender: Any) {
    }
}

extension AddEventMainInfoTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        eventData.description = textView.text
    }
}
