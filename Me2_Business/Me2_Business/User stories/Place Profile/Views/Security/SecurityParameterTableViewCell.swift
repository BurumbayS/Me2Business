//
//  SecurityParameterTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Cartography

enum SecurityParameter: String {
    case changePhone = "Изменить номер телефона"
    case changePassword = "Изменить пароль"
    case accessCode = "Код быстрого доступа"
    
    var showStatus: Bool {
        switch self {
        case .accessCode:
            return true
        default:
            return false
        }
    }
}

class SecurityParameterTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let statusLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        self.contentView.addSubview(titleLabel)
        constrain(titleLabel, self.contentView) { label, view in
            label.left == view.left + 20
            label.height == 20
            label.top == view.top + 20
            label.bottom == view.bottom - 20
        }
        
        statusLabel.textColor = .lightGray
        statusLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        self.contentView.addSubview(statusLabel)
        constrain(statusLabel, titleLabel, self.contentView) { status, title, view in
            status.centerY == title.centerY
            status.right == view.right - 10
        }
    }
    
    func configure(paramter: SecurityParameter, isOn: Bool = false) {
        self.accessoryType = .disclosureIndicator
        
        titleLabel.text = paramter.rawValue
        statusLabel.isHidden = !paramter.showStatus
        statusLabel.text = (isOn) ? "Вкл" : "Откл"
    }
}
