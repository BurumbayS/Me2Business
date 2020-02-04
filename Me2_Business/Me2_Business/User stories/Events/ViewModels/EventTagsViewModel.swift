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
    var eventMainType: Int!
    var selectedTags = [Tag]()
    var selectedTagIDs = [Int]()
    
    let eventData: EventData
    
    init(tagSelectionType: TagsSelectionType, eventData: EventData) {
        self.selectionType = tagSelectionType
        self.eventData = eventData
        
        if let type = eventData.event_type {
            eventMainType = type
        }
        self.selectedTagIDs = eventData.tags
    }
    
    func getTags(completion: ResponseBlock?) {
        let url = Network.core + "/tag/?tag_type=EVENT"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    for item in json["data"].arrayValue {
                        self.tags.append(Tag(json: item))
                    }
                    
                    self.selectedSingleTag = self.tags.first(where: { $0.id == self.eventMainType})
                    self.selectedTagIDs.forEach { (id) in
                        if let tag = self.tags.first(where: { $0.id == id }) {
                            self.selectedTags.append(tag)
                        }
                    }
                    
                    completion?(.ok, "")
                    
                case .failure(_):
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                }
        }
    }
    
    func isTagSelected(tag: Tag) -> Bool {
        switch selectionType {
        case .single:
            if selectedSingleTag != nil {
                return tag.id == selectedSingleTag!.id
            }
        default:
            return selectedTags.contains(where: { $0.id == tag.id })
        }
        
        return false
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
