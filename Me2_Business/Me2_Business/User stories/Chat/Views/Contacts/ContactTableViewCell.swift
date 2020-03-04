//
//  ContactTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

enum CheckStatus: String {
    case checked = "checked"
    case unchecked = "unchecked"
    
    func image() -> UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkStatusImageView: UIImageView!
    
    var checked = CheckStatus.unchecked
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addUnderline(with: Color.gray, and: self.contentView.frame.size)
    }
    
    func configure(contact: ContactUser, selectable: Bool = false, addable: Bool = false, added: Bool = false, onAdd: VoidBlock? = nil) {
        switch selectable {
        case true:
            checkStatusImageView.isHidden = false
            checkStatusImageView.image = checked.image()
        default:
            checkStatusImageView.isHidden = true
        }
        
        configureViews(for: contact)
    }
    
    private func configureViews(for contact: ContactUser) {
        avatarImageView.kf.setImage(with: URL(string: contact.avatar ?? ""), placeholder: UIImage(named: "placeholder_avatar"), options: [])
        nameLabel.text = contact.fullName
        usernameLabel.text = contact.username
    }
    
    func select() {
        switch checked {
        case .checked:
            checked = .unchecked
        default:
            checked = .checked
        }
        
        checkStatusImageView.image = checked.image()
    }
    
}
