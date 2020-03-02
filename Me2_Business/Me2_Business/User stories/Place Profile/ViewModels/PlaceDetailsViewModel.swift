//
//  PlaceDetailsViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class PlaceDetailsViewModel {
    var cells = [String : PlaceDetailCollectionCell]()
    let placeStatus: PlaceStatus
    let currentPage: Dynamic<Int>
    let place: Place
    
    init(place: Place, currentPage: Dynamic<Int>) {
        self.place = place
        self.placeStatus = place.regStatus
        self.currentPage = currentPage
    }
}
