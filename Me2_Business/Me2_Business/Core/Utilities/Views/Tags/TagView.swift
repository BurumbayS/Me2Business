//
//  TagView.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

enum TagSize {
    case large
    case medium
    case small
    
    var font: UIFont {
        switch self {
        case .large:
            return UIFont(name: "Roboto-Regular", size: 17)!
        case .medium:
            return UIFont(name: "Roboto-Medium", size: 13)!
        case .small:
            return UIFont(name: "Roboto-Regular", size: 11)!
        }
    }
    
    var sidesPadding: CGFloat {
        switch self {
        case .large:
            return 40
        default:
            return 20
        }
    }
    
    var height: CGFloat {
        switch self {
        case .large:
            return 30
        default:
            return 25
        }
    }
}

class TagView: UIView {
    
    let label = UILabel()
    
    var isSelected = false
    var tagsList: TagsList!
    
    func configure(with text: String, and tagsList: TagsList, of tagSize: TagSize) {
        self.tagsList = tagsList
        
        self.backgroundColor = Color.lightGray
        self.layer.cornerRadius = 5
        self.isUserInteractionEnabled = (tagSize == .large) ? true : false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectTag))
        self.addGestureRecognizer(tap)
        
        if tagsList.selectedList.contains(text) {
            self.backgroundColor = Color.red
            self.label.textColor = .white
        } else {
            self.label.textColor = .gray
            self.backgroundColor = Color.lightGray
        }
        label.text = text
        label.font = tagSize.font
        self.addSubview(label)
        constrain(label, self) { label, view in
            label.centerX == view.centerX
            label.centerY == view.centerY
        }
    }
    
    @objc private func selectTag() {
        isSelected = !isSelected
        
        switch isSelected {
        case true:
            self.backgroundColor = Color.red
            self.label.textColor = .white
            tagsList.selectedList.append(label.text ?? "")
        default:
            self.backgroundColor = Color.lightGray
            self.label.textColor = .gray
            tagsList.selectedList.removeAll(where: { $0 == self.label.text })
        }
    }
    
}
