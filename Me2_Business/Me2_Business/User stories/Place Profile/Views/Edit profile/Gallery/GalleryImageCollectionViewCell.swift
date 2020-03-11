//
//  GalleryImageCollectionViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/10/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class GalleryImageCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let checkedImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        
        self.contentView.addSubview(imageView)
        constrain(imageView, self.contentView) { image, view in
            image.left == view.left
            image.right == view.right
            image.top == view.top
            image.bottom == view.bottom
        }
        
        checkedImageView.image = UIImage(named: "checked")
        checkedImageView.isHidden = true
        
        self.contentView.addSubview(checkedImageView)
        constrain(checkedImageView, self.contentView) { image, view in
            image.right == view.right - 7
            image.top == view.top + 7
            image.height == 22
            image.width == 22
        }
    }
    
    func configure(image: String = "", isAddNewCell: Bool = false, selected: Bool = false) {
        if isAddNewCell {
            imageView.image = UIImage(named: "add_image_icon")
        } else {
            imageView.kf.setImage(with: URL(string: image), placeholder: UIImage(named: "default_place_wallpaper"), options: [])
        }
        
        checkedImageView.isHidden = !selected
    }
}
