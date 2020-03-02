//
//  SettingsParameterTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/2/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

enum SettingsParameter: String {
    case edit
    case contacts
    case notifications
    case security
    case feedback
    case about_app
    case logout
    
    var icon: UIImage {
        return UIImage(named: "\(self.rawValue)_icon")!
    }
    
    var title: String {
        switch self {
        case .edit:
            return "Редактировать профиль"
        case .contacts:
            return "Контакты"
        case .notifications:
            return "Уведомления"
        case .security:
            return "Безопасноcть"
        case .feedback:
            return "Обратная связь"
        case .about_app:
            return "О приложении"
        case .logout:
            return "Выйти"
        }
    }
}

class SettingsParameterTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(parameter: SettingsParameter) {
        iconImageView.image = parameter.icon
        titleLabel.text = parameter.title
        titleLabel.textColor = (parameter == .logout) ? Color.red : .black
        
        switch parameter {
        case .notifications:
            switcher.isHidden = false
        default:
            switcher.isHidden = true
            self.accessoryType = .disclosureIndicator
        }
    }
}
