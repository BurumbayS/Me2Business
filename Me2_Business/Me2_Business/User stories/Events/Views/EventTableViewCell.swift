//
//  EventTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var eventTypeView: UIView!
    @IBOutlet weak var eventWallpaperImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLogoImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var event: Event!
    
    private func configureViews() {
        layoutIfNeeded()
        
        eventTypeView.roundCorners([.topRight, .bottomRight], radius: 15, size: CGRect(x: 0, y: 0, width: eventTypeView.frame.width, height: eventTypeView.frame.height))
        
        backView.layer.cornerRadius = 5
        
        self.drawShadow(color: UIColor.black.cgColor, forOpacity: 0.3, forOffset: CGSize(width: 0, height: 0), radius: 5)
        self.backgroundColor = .clear
    }
    
    func configure(wtih event: Event) {
        self.event = event
        
        placeLogoImageView.kf.setImage(with: URL(string: event.place.logo ?? ""), placeholder: UIImage(named: "default_place_logo"), options: [])
        eventWallpaperImageView.kf.setImage(with: URL(string: event.imageURL ?? ""), placeholder: UIImage(named: "default_place_logo"), options: [])
        eventTypeLabel.text = event.eventType
        titleLabel.text = event.title
        locationLabel.text = event.place.name
        timeLabel.text = event.getTime()
        
        configureViews()
    }
    
}
