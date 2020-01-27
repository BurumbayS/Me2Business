//
//  ApplicationViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/9/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum ApplicationField {
    case placeName
    case address
    case adminName
    case phoneNumber
    case email
    
    var key: String {
        switch self {
        case .placeName:
            return "name"
        case .address:
            return "address"
        case .adminName:
            return "full_name"
        case .phoneNumber:
            return "phone"
        case .email:
            return "email"
        }
    }
    
    var title: String {
        switch self {
        case .placeName:
            return "Наименование заведения"
        case .address:
            return "Адрес заведения"
        case .adminName:
            return "Имя и Фамилия"
        case .phoneNumber:
            return "Контактный номер"
        case .email:
            return "E-mail"
        }
    }
    
    var placeholder: String {
        switch self {
        case .placeName:
            return "Наименование заведения"
        case .address:
            return "Адрес заведения"
        case .adminName:
            return "Имя и Фамилия"
        case .phoneNumber:
            return "Контактный номер"
        case .email:
            return "E-mail"
        }
    }
    
    var keyboardStyle: UIKeyboardType {
        switch self {
        case .placeName, .address, .adminName:
            return .default
        case .phoneNumber:
            return .phonePad
        case .email:
            return .emailAddress
        }
    }
}

class ApplicationViewModel {
    let fields = [ApplicationField.placeName, .address, .adminName, .phoneNumber, .email]
    var fieldsCorrectness = [ApplicationField : Dynamic<Bool>]()
    var fieldsData = [ApplicationField: Dynamic<String>]()
    var allFieldsCorrect: Dynamic<Bool>
    
    init() {
        allFieldsCorrect = Dynamic(false)
        
        for field in fields {
            let isCorrect = Dynamic(false)
            isCorrect.bind { [weak self] (isCorrect) in
                self?.checkFieldsCorrectness()
            }
            fieldsCorrectness[field] = isCorrect
            
            fieldsData[field] = Dynamic("")
        }
    }
    
    private func checkFieldsCorrectness() {
        for field in fields {
            if let isCorrect = fieldsCorrectness[field]?.value, !isCorrect {
                allFieldsCorrect.value = false
                return
            }
        }
        
        allFieldsCorrect.value = true
    }
    
    func sendApplication(completion: ResponseBlock?) {
        let url = Network.business + "/registration_request/"
        
        var params: Parameters = [:]
        for field in fields {
            params[field.key] = fieldsData[field]?.value
        }
        
        
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    completion?(.ok, "")
                    
                case .failure(_):
                    let json = JSON(response.data as Any)
                    print(json)
                    completion?(.fail, json["message"].stringValue)
                }
        }
    }
}
