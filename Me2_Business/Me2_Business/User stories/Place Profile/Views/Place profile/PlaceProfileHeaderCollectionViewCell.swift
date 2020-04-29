//
//  PlaceProfileHeaderCollectionViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography
import Cosmos
import ImageSlideshow
import Kingfisher

class PlaceProfileHeaderCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let wallpaperView = UIView()
    let imageCarousel = ImageSlideshow()
    let stackView = UIStackView()
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let ratingView = CosmosView()
    let ratingLabel = UILabel()
    
    var parentVC: UIViewController!
    
    var place: Place!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(place: Place, viewController: UIViewController) {
        self.place = place
        
        parentVC = viewController
        
        configureViewsWithData()
    }
    
    private func configureViewsWithData() {
        titleLabel.text = place.name
        logoImageView.kf.setImage(with: URL(string: place.logo ?? ""), placeholder: UIImage(named: "default_place_logo"), options: [])
        categoryLabel.text = place.category
        
        if let rating = place.rating {
            let roundedRating = Double(round(rating * 10) / 10)
            ratingView.rating = roundedRating
            ratingView.text = "\(roundedRating)"
        } else {
            ratingView.isHidden = true
        }
        
        var imageInputs = [InputSource]()
        for image in place.imageList {
            let imageURL = image.url
            let source = KingfisherSource(url: URL(string: imageURL)!, placeholder: UIImage(named: "default_place_wallpaper"), options: [])
            imageInputs.append(source)
        }
        if (imageInputs.count == 0) { imageInputs.append(ImageSource(image:  UIImage(named: "default_place_wallpaper")!)) }
        imageCarousel.setImageInputs(imageInputs)
    }
    
    private func setUpViews() {
        setUpWallpaperView()
        setUpPlaceHeader()
    }
    
    private func setUpWallpaperView() {
        setUpDefaultWalppaper()
        setupImageCarousel()
        
        self.contentView.addSubview(wallpaperView)
        constrain(self.wallpaperView, self.contentView) { wallpaper, view in
            wallpaper.left == view.left
            wallpaper.top == view.top
            wallpaper.right == view.right
        }
    }
    
    private func setUpDefaultWalppaper() {
        imageView.image = UIImage(named: "default_place_wallpaper")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.wallpaperView.addSubview(imageView)
        constrain(imageView, self.wallpaperView) { image, view in
            image.left == view.left
            image.top == view.top
            image.right == view.right
            image.bottom == view.bottom
        }
    }
    
    private func setupImageCarousel() {
        imageCarousel.contentScaleMode = .scaleAspectFill
        imageCarousel.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: 30))
        imageCarousel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showImages)))
        self.wallpaperView.addSubview(imageCarousel)
        constrain(imageCarousel, self.wallpaperView) { image, view in
            image.left == view.left
            image.top == view.top
            image.right == view.right
            image.bottom == view.bottom
        }
    }
    
    private func setUpPlaceHeader() {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        logoImageView.layer.cornerRadius = 20
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        constrain(logoImageView, view) { logo, view in
            logo.left == view.left + 20
            logo.top == view.top + 20
            logo.height == 40
            logo.width == 40
        }
        
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 17)
        view.addSubview(titleLabel)
        constrain(titleLabel, logoImageView) { title, logo in
            title.left == logo.right + 10
            title.centerY == logo.centerY
            title.top == logo.top
            title.bottom == logo.bottom
        }
        
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "settings_icon"), for: .normal)
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchDown)
        view.addSubview(settingsButton)
        constrain(settingsButton, titleLabel, view) { btn, label, view in
            btn.centerY == label.centerY
            btn.left == label.right + 10
            btn.right == view.right - 20
            btn.height == 20
            btn.width == 20
        }
        
        ratingView.isUserInteractionEnabled = false
        ratingView.settings.starSize = 10
        ratingView.settings.starMargin = 3
        ratingView.settings.totalStars = 5
        view.addSubview(ratingView)
        constrain(ratingView, logoImageView) { rating, logo in
            rating.leading == logo.leading
            rating.top == logo.bottom + 10
            rating.height == 15
            rating.width == 90
        }
        
        categoryLabel.textColor = .darkGray
        categoryLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        view.addSubview(categoryLabel)
        constrain(categoryLabel, ratingView) { category, rating in
            category.leading == rating.leading
            category.top == rating.bottom + 5
        }
        
        self.contentView.addSubview(view)
        constrain(view, wallpaperView, self.contentView) { view, image, superview in
            view.top == image.bottom - 20
            view.left == superview.left
            view.right == superview.right
            view.bottom == superview.bottom
            view.height == 110
        }
    }
    
    @objc private func showImages() {
        imageCarousel.presentFullScreenController(from: parentVC)
    }
    
    @objc private func showSettings() {
        let vc = Storyboard.settingsViewController() as! SettingsViewController
        vc.viewModel = SettingsViewModel(place: place)
        parentVC.navigationController?.pushViewController(vc, animated: true)
    }
}
