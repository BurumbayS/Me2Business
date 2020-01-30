//
//  Checkbox.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/29/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class Checkbox: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var checkFlag: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comminInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        comminInit()
    }
    
    private func comminInit() {
        Bundle.main.loadNibNamed("Checkbox", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func select() {
        checkFlag.image = UIImage(named: "selected_checkbox")
    }
    
    func unselect() {
        checkFlag.image = UIImage(named: "empty_checkbox")
    }
}
