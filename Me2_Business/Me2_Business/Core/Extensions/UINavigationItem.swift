//
//  UINavigationItem.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/7/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

extension UINavigationItem {
    
    func twoLineTitleView(titles: [String], colors: [UIColor], fonts: [UIFont]) {
        let titleView = UIView()
        let firstLabel = UILabel()
        firstLabel.textColor = colors[0]
        firstLabel.font = fonts[0]
        firstLabel.text = titles[0]
        titleView.addSubview(firstLabel)
        constrain(firstLabel, titleView) { label, view in
            label.centerX == view.centerX
            label.top == view.top
        }
        
        let secondLabel = UILabel()
        secondLabel.textAlignment = .center
        secondLabel.textColor = colors[1]
        secondLabel.font = fonts[1]
        secondLabel.text = titles[1]
        titleView.addSubview(secondLabel)
        constrain(secondLabel, firstLabel, titleView) { firstLabel, secondLabel, view in
            firstLabel.centerX == view.centerX
            firstLabel.top == secondLabel.bottom
            firstLabel.bottom == view.bottom
            firstLabel.width == UIScreen.main.bounds.width * 0.5
        }
        
        self.titleView = titleView
    }
}
