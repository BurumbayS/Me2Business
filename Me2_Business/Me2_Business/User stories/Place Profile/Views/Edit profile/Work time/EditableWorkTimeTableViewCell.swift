 //
//  EditableWorkTimeTableViewCell.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/5/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit

class EditableWorkTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var daySelectedCheck: UIButton!
    @IBOutlet weak var timeFromTextField: UITextField!
    @IBOutlet weak var timeToTextField: UITextField!
    @IBOutlet weak var daynnightCheck: UIButton!
    @IBOutlet weak var daynnightLabel: UILabel!
    
    var weekDaySelected = false
    var daynnightSelected = false
    
    var dayNnightSelectionHandler: VoidBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureViews()
    }
    
    private func configureViews() {
        daynnightCheck.layer.cornerRadius = 5
        daynnightCheck.layer.borderColor = Color.gray.cgColor
        daynnightCheck.layer.borderWidth = 1
        
        timeFromTextField.keyboardType = .numberPad
        timeToTextField.keyboardType = .numberPad
        
        //configure day'N'night label depend on screen width
        daynnightLabel.text = (UIScreen.main.bounds.width == 320) ? "24 ч." : "Круглосуточно"
    }

    func configure(weekDay: WeekDay, onDayNnightSelected: VoidBlock?) {
        self.dayNnightSelectionHandler = onDayNnightSelected
        
        weekdayLabel.text = weekDay.name.localTitle
        timeFromTextField.text = weekDay.start
        timeToTextField.text = weekDay.end
        
        weekDaySelected = weekDay.works
        switch weekDaySelected {
        case true:
            daySelectedCheck.isHidden = false
            weekdayLabel.textColor = Color.blue
        default:
            daySelectedCheck.isHidden = true
            weekdayLabel.textColor = .darkGray
        }
        
        daynnightSelected = weekDay.dayNnight
        switch daynnightSelected {
        case true:
            daynnightCheck.setImage(UIImage(named: "blue_checked_icon"), for: .normal)
        default:
            daynnightCheck.setImage(nil, for: .normal)
        }
    }
    
    func selectWeekday() {
        switch weekDaySelected {
        case true:
            daySelectedCheck.isHidden = true
            weekdayLabel.textColor = .darkGray
        default:
            daySelectedCheck.isHidden = false
            weekdayLabel.textColor = Color.blue
        }
        
        weekDaySelected = !weekDaySelected
    }
    
    func selectDaynNight() {
        switch daynnightSelected {
        case true:
            daynnightCheck.setImage(UIImage(), for: .normal)
        default:
            daynnightCheck.setImage(UIImage(named: "blue_checked_icon"), for: .normal)
        }
        
        daynnightSelected = !daynnightSelected
    }
    
    @IBAction func dayNnightPressed(_ sender: Any) {
        dayNnightSelectionHandler?()
    }
 }
