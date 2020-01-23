//
//  UIButtonExtensions.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/9/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

extension UIButton {
    func enable() {
        self.isEnabled = true
        self.alpha = 1.0
    }
    func disable() {
        self.isEnabled = false
        self.alpha = 0.5
    }
}
