//
//  PlaceDetailsCollectionCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class PlaceDetailCollectionCell: UICollectionViewCell {
    var presenterDelegate: ControllerPresenterDelegate!
    
    func configure(presenterDelegate: ControllerPresenterDelegate) {
        self.presenterDelegate = presenterDelegate
    }
    
    func reload() {}
}
