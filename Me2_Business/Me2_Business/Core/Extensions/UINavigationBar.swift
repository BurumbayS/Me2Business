//
//  UINavigationBar.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/7/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
    
    func makeTransparentBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.backgroundColor = .clear
    }
}
