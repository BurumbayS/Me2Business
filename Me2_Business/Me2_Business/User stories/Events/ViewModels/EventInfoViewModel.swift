//
//  EventInfoViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class EventInfoViewModel {
    var event: Event
    
    var dataLoaded = false
    let eventArchivationHandler: VoidBlock?
    
    init(event: Event, onEventArchived: VoidBlock?) {
        self.event = event
        self.eventArchivationHandler = onEventArchived
    }
    
    func fetchData(completion: ResponseBlock?) {
        let url = Network.business + "/event/\(event.id)/"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { [weak self] (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    let event = Event(json: json["data"])
                    
                    self?.event = event
                    self?.dataLoaded = true
                    
                    completion?(.ok, "")
                    
                case .failure(_):
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                }
        }
    }
    
    func archiveEvent(completion: ResponseBlock?) {
        let url = Network.business + "/event/\(event.id)/archive/"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    self.event = Event(json: json["data"])
                    
                    self.eventArchivationHandler?()
                    
                    completion?(.ok, "")
                    
                case .failure(_):
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                }
        }
    }
    
    func getTagsList() -> TagsList {
        var tags = [String]()
        
        for tag in event.tags {
            tags.append(tag.name)
        }
        
        return TagsList(items: tags, selectedItems: [])
    }
}
