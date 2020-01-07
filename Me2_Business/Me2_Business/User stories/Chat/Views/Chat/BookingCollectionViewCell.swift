//
//  BookingCollectionViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/7/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class BookingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var messageLeftPadding: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        backView.drawShadow(forOpacity: 0.3, forOffset: CGSize(width: 0, height: 0), radius: 3)
    }
    
    func configure(message: Message) {
        textLabel.text = message.text
        statusView.isHidden = (message.booking?.status == .NEW) ? true : false
        
        switch message.isMine() {
        case true:
            messageLeftPadding.constant = UIScreen.main.bounds.width - 290 - 10
        default:
            messageLeftPadding.constant = 10
        }
        
        self.contentView.layoutIfNeeded()
    }

}
