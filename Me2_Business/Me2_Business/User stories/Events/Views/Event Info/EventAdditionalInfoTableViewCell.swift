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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(event: Event) {
        publicationDate.text = event.getDateString()
        if let cnt = event.favourite_count { savesCount.text = "\(cnt)" }
    }
    
}
