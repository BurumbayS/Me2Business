//
//  PlaceInfoViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum PlaceInfoSection: String {
    case description
    case address
    case workTime
    case phone
    case instagram
    case site
    case mail
    case tags
//    case subsidiaries
}

class PlaceInfoViewModel {
    var placeSections = [PlaceInfoSection]()
    var placeInfo: Place!
    var placeID: Int!
    var placeStatus: PlaceStatus!
    
    var dataLoaded = false
    
    init(place: Place) {
        self.placeInfo = place
        
        configureSections()
    }
    
    private func configureSections() {
        placeSections = [.description, .address, .workTime, .phone, .instagram, .mail, .site, .tags]
        
//        if let subs = placeInfo.subsidiaries, subs.count > 0 {
//            placeSections.append(.subsidiaries)
//        }
    }
    
    func info(forSection section: PlaceInfoSection) -> String {
        switch section {
        case .mail:
            return placeInfo.email ?? ""
        case .phone:
            return placeInfo.phone ?? ""
        case .instagram:
            return placeInfo.instagram ?? ""
        case .site:
            return placeInfo.website ?? ""
        default:
            return ""
        }
    }

}
