//
//  EditMainInfoTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditMainInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var placeInfo: Place!
    var parentVC: UIViewController!
    
    var editLogoHandler: VoidBlock?
    var imagePicker = UIImagePickerController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        descriptionTextView.contentInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        descriptionTextView.delegate = self
        
        imagePicker.delegate = self
    }
    
    func configure(place: Place, vc: UIViewController) {
        self.placeInfo = place
        self.parentVC = vc
        
        titleLabel.text = place.name
        categoryLabel.text = place.category
        logoImageView.kf.setImage(with: URL(string: place.logo ?? ""), placeholder: UIImage(named: "default_place_logo"), options: [])
        descriptionTextView.text = place.description
    }
    
    @IBAction func chooseLogoPressed(_ sender: Any) {
        parentVC.addActionSheet(titles: ["Камера","Фотопленка"], actions: [openCamera, openPhotolibrary], styles: [.default, .default])
    }
    
    private func openCamera() {
        imagePicker.sourceType = .camera
        
        parentVC.present(imagePicker, animated: true, completion: nil)
    }
    
    private func openPhotolibrary() {
        imagePicker.sourceType = .photoLibrary
        
        parentVC.present(imagePicker, animated: true, completion: nil)
    }
    
}

extension EditMainInfoTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            logoImageView.image = pickedImage
            placeInfo.newLogo = pickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension EditMainInfoTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeInfo.description = textView.text
    }
}
