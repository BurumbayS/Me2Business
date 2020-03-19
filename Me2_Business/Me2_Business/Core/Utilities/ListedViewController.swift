//
//  ListedViewController.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class ListedViewController: UIViewController {

    let emptyListStatusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmptyListStatusLabel()
    }
    
    private func setupEmptyListStatusLabel() {
        emptyListStatusLabel.isHidden = true
        emptyListStatusLabel.textColor = .darkGray
        emptyListStatusLabel.textAlignment = .center
        emptyListStatusLabel.numberOfLines = 0
        emptyListStatusLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        self.view.addSubview(emptyListStatusLabel)
        constrain(emptyListStatusLabel, self.view) { label, view in
            label.centerX == view.centerX
            label.centerY == view.centerY - 50
            label.width == 250
        }
    }
    
    func showEmptyListStatusLabel(withText text: String) {
        emptyListStatusLabel.text = text
        emptyListStatusLabel.isHidden = false
    }

    func hideEmptyListStatusLabel() {
        emptyListStatusLabel.isHidden = true
    }

}
