//
//  ContactTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addUnderline(with: Color.gray, and: self.contentView.frame.size)
    }
    
    func configure(contact: ContactUser, selectable: Bool = false, addable: Bool = false, added: Bool = false, onAdd: VoidBlock? = nil) {
        configureViews(for: contact)
    }
    
    private func configureViews(for contact: ContactUser) {
        avatarImageView.kf.setImage(with: URL(string: contact.avatar ?? ""), placeholder: UIImage(named: "placeholder_avatar"), options: [])
        nameLabel.text = contact.fullName
        usernameLabel.text = contact.username
    }
    
}
