//
//  SettingsViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/2/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class SettingsViewModel {
    let parameters = [SettingsParameter.edit, .contacts, .notifications, .security, .feedback, .about_app, .logout]
    
    let placeInfo: Place
    
    init(place: Place) {
        self.placeInfo = place
    }
    
    func switchNotifications(isOn: Bool) {
        let url = Network.user + "/update_notification_data/"
        let params = [  "inbound_messages": isOn,
                        "live_chat": isOn,
                        "booking_status": isOn,
                        "events_and_promo": isOn
                        ]
        
        Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                case .failure(_):
                    
                    let json = JSON(response.data as Any)
                    print(json)
                    
                }
        }
    }
}
