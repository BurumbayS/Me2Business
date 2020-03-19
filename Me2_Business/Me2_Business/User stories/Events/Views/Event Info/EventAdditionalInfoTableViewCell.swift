//
//  EventAdditionalInfoTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EventAdditionalInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var publicationDate: UILabel!
    @IBOutlet weak var savesCount: UILabel!
    @IBOutlet weak var archivedDateView: UIView!
    @IBOutlet weak var archivedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        archivedDateView.isHidden = true
    }
    
    func configure(event: Event) {
        switch event.status {
        case .ACTIVE:
            publicationDate.text = event.getDateString()
            if let cnt = event.favourite_count { savesCount.text = "\(cnt)" }
        default:
            archivedDateView.isHidden = false
//            archivedDateLabel.text = event
        }
    }
    
}
