//
//  AccessCodeViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 4/2/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

enum AccessCodeType {
    case enter
    case confirm
    case create
    case check
    
    var title: String {
        switch self {
        case .enter:
            return "Введите код доступа"
        case .create:
            return "Придумайте код быстрого доступа"
        case .confirm:
            return "Подтвердите код быстрого доступа"
        case .check:
            return "Введите код доступа"
        }
    }
}

class AccessCodeViewModel {
    let accessCode: Dynamic<String>
    var accesCodeType: AccessCodeType
    var createdAccessCode = ""
    let correctAccessCodeHandler: VoidBlock?
    
    init(type: AccessCodeType = .enter, onCorrectAccessCode: VoidBlock? = nil) {
        accessCode = Dynamic("")
        accesCodeType = type
        correctAccessCodeHandler = onCorrectAccessCode
    }
}
