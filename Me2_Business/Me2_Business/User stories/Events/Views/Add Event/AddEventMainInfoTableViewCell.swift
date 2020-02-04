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
    @IBOutlet weak var wallpaperImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    var presenterDelegate: ControllerPresenterDelegate!
    var actionSheetPresenterDelegate: ActionSheetPresenterDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    func configure(data: EventData, presenterDelegate: ControllerPresenterDelegate, actionSheetPresenterDelegate: ActionSheetPresenterDelegate) {
        super.configure(data: data)
        
        self.presenterDelegate = presenterDelegate
        self.actionSheetPresenterDelegate = actionSheetPresenterDelegate
        
        if let url = eventData.imageURL {
            wallpaperImageView.isHidden = false
            wallpaperImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "default_place_logo"), options: [])
        }
        titleTextField.text = eventData.name
        descriptionTextView.text = eventData.description
    }
    
    private func configureViews() {
        imagePicker.delegate = self
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = Color.gray.cgColor
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.delegate = self
        
        titleTextField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
    }
    
    @objc private func titleChanged() {
        eventData.name = titleTextField.text!
    }
    
    private func showCamera() {
        imagePicker.sourceType = .camera
        presenterDelegate.present(controller: imagePicker, presntationType: .present, completion: nil)
    }
    
    private func showPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        presenterDelegate.present(controller: imagePicker, presntationType: .present, completion: nil)
    }
    
    @IBAction func addWallpaperPressed(_ sender: Any) {
        actionSheetPresenterDelegate.present(with: ["Камера","Выбрать фото"], actions: [showCamera, showPhotoLibrary], styles: [.default, .default])
    }
}

extension AddEventMainInfoTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        eventData.description = textView.text
    }
}

extension AddEventMainInfoTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            wallpaperImageView.image = pickedImage
            wallpaperImageView.isHidden = false
            
            eventData.image = pickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
