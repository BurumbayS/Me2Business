//
//  ProfileHeaderTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import ImageSlideshow

class ProfileHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: ImageSlideshow!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    
    var user: User!
//    var viewModel: UserProfileViewModel!
    var parentVC: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
        
    func configure(user: User, viewController: UIViewController) {
//        self.viewModel = viewModel
        self.user = user
        self.parentVC = viewController
        
        if let url = URL(string: user.avatar ?? "") {
            avatarImageView.setImageInputs([KingfisherSource(url: url, placeholder: UIImage(named: "placeholder_avatar"), options: [])])
        } else {
            avatarImageView.setImageInputs([ImageSource(image: UIImage(named: "placeholder_avatar")!)])
        }
        
        usernameLabel.text = user.username
        nameLabel.text = user.fullName ?? ""
        bioLabel.text = user.bio ?? ""
        if let instagram = user.instagram, instagram != "" {
            instagramLabel.textColor = Color.blue
            instagramLabel.isUserInteractionEnabled = true
            instagramLabel.text = instagram
        } else {
            instagramLabel.textColor = .lightGray
            instagramLabel.isUserInteractionEnabled = false
            instagramLabel.text = "не указан"
        }
    }
    
    private func configureViews() {
        instagramLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openInstagram)))
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showBigAvatar)))
        avatarImageView.contentScaleMode = .scaleAspectFill
        
        writeButton.layer.borderWidth = 1
        writeButton.layer.borderColor = Color.blue.cgColor
        writeButton.layer.cornerRadius = 20
    }
    
    @objc private func openInstagram() {
        if let url = URL(string: "https://www.instagram.com/\(user.instagram!)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func showBigAvatar() {
        avatarImageView.presentFullScreenController(from: parentVC)
    }
    
    @IBAction func writeButtonPressed(_ sender: Any) {
    }
}
