//
//  EventsTabViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class EventsTabViewModel {
    var events = [Event]()
    
    func getEvents(completion: ResponseBlock?) {
        Alamofire.request(eventURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    for item in json["data"]["results"].arrayValue {
                        self.events.append(Event(json: item))
                    }
                    
                    completion?(.ok, "")
                    
                case .failure(_):
                    
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                    
                }
        }
    }
    
    let eventURL = Network.business + "/event/"
}
