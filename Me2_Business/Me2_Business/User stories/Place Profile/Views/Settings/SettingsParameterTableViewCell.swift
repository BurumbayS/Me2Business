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
    
    var onSwitchHandler: ((Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSwitcher()
    }
    
    private func setupSwitcher() {
        switcher.addTarget(self, action: #selector(switchParameter), for: .allEvents)
    }
    
    @objc private func switchParameter() {
        onSwitchHandler?(switcher.isOn)
    }
    
    func configure(parameter: SettingsParameter, onSwitch: ((Bool) -> ())?) {
        self.onSwitchHandler = onSwitch
        
        iconImageView.image = parameter.icon
        titleLabel.text = parameter.title
        titleLabel.textColor = (parameter == .logout) ? Color.red : .black
        
        switch parameter {
        case .notifications:
            switcher.isHidden = false
            switcher.isOn = (UserDefaults().object(forKey: UserDefaultKeys.notificationsSubscriptionStatus.rawValue) as? Bool) ?? false
        default:
            switcher.isHidden = true
        }
        
        switch parameter {
        case .notifications, .logout:
            self.accessoryType = .none
        default:
            self.accessoryType = .disclosureIndicator
        }
    }
}
