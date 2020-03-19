//
//  EventLocationAndWorkTimeTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EventLocationAndWorkTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var availableTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(location: String?, time: String?) {
        locationLabel.text = location
        availableTimeLabel.text = time
    }
}
