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
    var archivedEvents = [Event]()
    
    func getEvents(completion: ResponseBlock?) {
        Alamofire.request(eventURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    var events = [Event]()
                    for item in json["data"]["results"].arrayValue {
                        events.append(Event(json: item))
                    }
                    
                    self.sortEvents(events: events, completion: completion)
                    
                case .failure(_):
                    
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                    
                }
        }
    }
    
    private func sortEvents(events: [Event], completion: ResponseBlock?) {
        for event in events {
            if event.status == .ACTIVE {
                self.events.append(event)
            } else {
                self.archivedEvents.append(event)
            }
        }
        
        completion?(.ok, "")
    }
    
    let eventURL = Network.business + "/event/"
}
