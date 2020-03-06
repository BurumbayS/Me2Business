//
//  EditTagsViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

enum EditTagsParameters {
    case kitchen
    case mainDish
    case extra
    case halal
    case businessLunch
    case averageBill
    
    var cellType: EditTagsCellType {
        switch self {
        case .kitchen, .mainDish, .extra:
            return .toChoose
        case .halal:
            return .selectable
        case .businessLunch, .averageBill:
            return .withPrice
        }
    }
    
    var title: String {
        switch self {
        case .kitchen:
            return "Вид кухни"
        case .mainDish:
            return "Основное блюдо"
        case .extra:
            return "Дополнительно"
        case .halal:
            return "Халал"
        case .businessLunch:
            return "Бизнес-ланч от"
        case .averageBill:
            return "Средний чек"
        }
    }
}

class EditTagsViewModel {
    let parameters = [EditTagsParameters.kitchen, .mainDish, .extra, .halal, .businessLunch, .averageBill]
}
