//
//  SelectTagsVIewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/10/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class PlaceTagsListViewModel {
    let tagsType: String
    let data: TagsDataToSave
    
    var tagsList = [Tag]()
    
    init(type: String, data: TagsDataToSave) {
        self.tagsType = type
        self.data = data
    }
    
    func getTags(completion: ResponseBlock?) {
        let url = Network.core + "/tag/?tag_type=\(tagsType)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    for item in json["data"].arrayValue {
                        let tag = Tag(json: item)
                        self.tagsList.append(tag)
                        if self.data.placeTagNames.contains(tag.name) {
                            self.data.tagIDs.append(tag.id)
                        }
                    }
                    
                    completion?(.ok, "")
                    
                case .failure(_ ):
                    let json = JSON(response.data as Any)
                    print(json)
                    completion?(.fail, json["message"].stringValue)
                }
        }
    }
    
    func selectTag(atIndex index: Int) {
        if let pos = data.tagIDs.firstIndex(of: tagsList[index].id) {
            data.tagIDs.remove(at: pos)
        } else {
            data.tagIDs.append(tagsList[index].id)
        }
    }
}
