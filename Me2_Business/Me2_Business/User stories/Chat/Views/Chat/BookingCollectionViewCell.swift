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
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var acceptButtonHeight: NSLayoutConstraint!
    
    var acceptionHandler: VoidBlock?
    var rejectionHandler: VoidBlock?
    var editionHandler: VoidBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        backView.drawShadow(forOpacity: 0.3, forOffset: CGSize(width: 0, height: 0), radius: 3)
    }
    
    func configure(message: Message, onAccept: VoidBlock?, onReject: VoidBlock?, onEdit: VoidBlock?) {
        self.acceptionHandler = onAccept
        self.rejectionHandler = onReject
        self.editionHandler = onEdit
        
        textLabel.text = message.text
        statusView.isHidden = (message.booking?.status == .NEW) ? true : false
        
        acceptButtonHeight.constant = (message.booking?.status == .NEW) ? 40 : 0
        
        switch message.booking?.status {
        case .APPROVED?:
            statusLabel.textColor = Color.blue
            statusLabel.text = "Подтверждено"
        case .REJECTED?:
            statusLabel.textColor = Color.red
            statusLabel.text = "Отклонено"
        default:
            break
        }
        
        switch message.isMine() {
        case true:
            messageLeftPadding.constant = UIScreen.main.bounds.width - 290 - 10
        default:
            messageLeftPadding.constant = 10
        }
        
        self.contentView.layoutIfNeeded()
    }

    @IBAction func rejectPressed(_ sender: Any) {
        rejectionHandler?()
    }
    
    @IBAction func editPressed(_ sender: Any) {
        editionHandler?()
    }
    
    @IBAction func acceptPressed(_ sender: Any) {
        acceptionHandler?()
    }
}
