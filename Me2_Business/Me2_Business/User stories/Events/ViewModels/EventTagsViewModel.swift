//
//  EventTagsViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/31/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum TagsSelectionType {
    case multi
    case single
}

class EventTagsViewModel {
    var selectionType: TagsSelectionType = .multi
    var tags = [Tag]()
    
    var selectedSingleTag: Tag?
    var selectedTags = [Tag]()
    
    let eventData: EventData
    
    init(tagSelectionType: TagsSelectionType, eventData: EventData) {
        self.selectionType = tagSelectionType
        self.eventData = eventData
    }
    
    func getTags(completion: ResponseBlock?) {
        let url = Network.core + "/tag/?tag_type=EVENT"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    for item in json["data"].arrayValue {
                        self.tags.append(Tag(json: item))
                    }
                    
                    completion?(.ok, "")
                    
                case .failure(_):
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                }
        }
    }
    
    func selectedTag(atIndexPath indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        switch selectionType {
        case .single:
            selectedSingleTag = tag
            eventData.event_type = tag.id
        case .multi:
            if let index = selectedTags.firstIndex(where: { $0.id == tag.id }) {
                selectedTags.remove(at: index)
                eventData.tags.removeAll(where: { $0 == tag.id })
            } else {
                selectedTags.append(tag)
                eventData.tags.append(tag.id)
            }
        }
    }
}
