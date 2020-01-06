//
//  MediaFile.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class MediaFile {
    static let mediaFileCellID = "MediaCell"
    
    let id: Int
    let file: String
    let thumbnail: String
    var thumbnailImage: UIImage?
    
    init(json: JSON = JSON()) {
        id = json["id"].intValue
        file = json["file"].stringValue
        thumbnail = json["thumbnail"].stringValue
    }
    
}
