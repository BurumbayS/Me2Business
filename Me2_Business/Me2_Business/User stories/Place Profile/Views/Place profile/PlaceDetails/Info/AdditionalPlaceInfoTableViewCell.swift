//
//  AdditionalPlaceInfoTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

enum AdditionalPlaceInfoType: String {
    case phone
    case mail
    case site
    case instagram
    
    var icon: UIImage {
        return UIImage(named: "\(self.rawValue)_icon")!
    }
    
    var textColor: UIColor {
        switch self {
        case .phone, .instagram:
            return .darkGray
        default:
            return Color.blue
        }
    }
}

class AdditionalPlaceInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(type: AdditionalPlaceInfoType, detail: String) {
        iconImageView.image = type.icon
        detailLabel?.text = detail
        detailLabel?.textColor = type.textColor
    }
    
}
