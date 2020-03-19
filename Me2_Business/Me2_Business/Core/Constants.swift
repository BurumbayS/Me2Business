//
//  Constants.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

import UIKit

class Constants {
    static let shared = Constants()
    
    //minimal allowable content size for tab section in place profile (minus the top bar and header)
    var minContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
}
