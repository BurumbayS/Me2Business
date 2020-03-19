//
//  AnswerToTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/13/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

class AnswerToTableViewCell: UITableViewCell {

    let answerButton = UIButton()
    
    var answerPressHandler: VoidBlock?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        answerButton.setTitle("Ответить", for: .normal)
        answerButton.setTitleColor(Color.red, for: .normal)
        answerButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        answerButton.addTarget(self, action: #selector(answerToReview), for: .touchUpInside)
        
        self.contentView.addSubview(answerButton)
        constrain(answerButton, self.contentView) { btn, view in
            btn.right == view.right - 20
            btn.top == view.top + 20
            btn.height == 20
            btn.width == 70
            btn.bottom == view.bottom - 20
        }
    }
    
    func configure(onAnswerPressed: VoidBlock?) {
        answerPressHandler = onAnswerPressed
    }
    
    @objc private func answerToReview() {
        answerPressHandler?()
    }
}
