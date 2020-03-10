//
//  EditTagsTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

enum EditTagsCellType {
    case selectable
    case withPrice
    case toChoose
}

class EditTagsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pricaTextField: UITextField!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var enterPriceView: UIView!
    
    var parameter: EditTagsParameters!
    var data: TagsDataToSave!
    
    let picker = UIPickerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        pricaTextField.inputView = picker
        pricaTextField.textAlignment = .center
        
        picker.delegate = self
        picker.dataSource = self
    }
    
    func configure(parameter: EditTagsParameters, data: TagsDataToSave) {
        self.data = data
        self.parameter = parameter
        
        titleLabel.text = parameter.title
        
        checkImageView.isHidden = true
        
        switch parameter.cellType {
        case .withPrice:
            enterPriceView.isHidden = false
        default:
            enterPriceView.isHidden = true
        }
        
        switch parameter.cellType {
        case .toChoose:
            self.accessoryType = .disclosureIndicator
        default:
            self.accessoryType = .none
        }
        
        switch parameter {
        case .businessLunch:
            pricaTextField.text = "\(data.businessLaunchPrice)"
        case .averageBill:
            pricaTextField.text = "\(data.averageBillPrice)"
        default:
            break
        }
    }

}

extension EditTagsTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch parameter {
        case .businessLunch:
            
            //business lunch starts from 700 and goes to 5000 by 100
            return (5000 - 600) / 100
            
        case .averageBill:
            
            //average bill starts from 1000 and goes to 50 000 by 500
            return (50000 - 900) / 500
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch parameter {
        case .businessLunch:
            
            //business lunch starts from 700 and goes to 5000 by 100
            let value = 700 + (100 * row)
            return "\(value)"
            
        case .averageBill:
            
            //average bill starts from 1000 and goes to 50 000 by 500
            let value = 1000 + (500 * row)
            return "\(value)"
            
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var value = 0
        
        switch parameter {
        case .businessLunch:
            value = 700 + (100 * row)
            data.businessLaunchPrice = value
        case .averageBill:
            value = 1000 + (500 * row)
            data.averageBillPrice = value
        default:
            break
        }
        
        pricaTextField.text = "\(value)"
    }
}
