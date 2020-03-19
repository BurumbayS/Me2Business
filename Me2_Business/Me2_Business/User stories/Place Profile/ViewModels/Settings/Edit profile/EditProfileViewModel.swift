//
//  EditProfileViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum AdditionalInfoType {
    case workTime
    case tags
    case gallery
    case menu
    
    var title: String {
        switch self {
        case .workTime:
            return "График работы"
        case .tags:
            return "Тэги"
        case .menu:
            return "Меню"
        case .gallery:
            return "Галерея"
        }
    }
}

enum EditProfileSection {
    case mainInfo
    case phone
    case instagram
    case website
    case additional
    
    var title: String {
        switch self {
        case .phone:
            return "Номер телефона"
        case .instagram:
            return "Инстаграм"
        case .website:
            return "Вебсайт"
        default:
            return ""
        }
    }
}

class TagsDataToSave {
    var businessLaunchPrice = 0
    var averageBillPrice = 0
    var tagIDs = [Int]()
    var placeTagNames = [String]()
}

class EditProfileViewModel {
    let sections = [EditProfileSection.mainInfo, .phone, .instagram, .website, .additional]
    let additionalCells = [AdditionalInfoType.workTime, .tags, .gallery, .menu]
    
    var placeInfo: Place
    let editedPlaceInfo: Dynamic<Place>
    let tagsData: Dynamic<TagsDataToSave> = Dynamic(TagsDataToSave())
    
    init(place: Place) {
        self.placeInfo = place
        self.editedPlaceInfo = Dynamic(place)
        self.tagsData.value.placeTagNames = place.tags
        self.tagsData.value.averageBillPrice = place.averageCheck
        self.tagsData.value.businessLaunchPrice = place.businessLunch
    }
    
    func dataForSection(atIndex index: Int) -> String {
        switch sections[index] {
        case .phone:
            return placeInfo.phone ?? ""
        case .instagram:
            return placeInfo.instagram ?? ""
        case .website:
            return placeInfo.website ?? ""
        default:
            return ""
        }
    }
    
    func updatePlaceInfo(completion: ResponseBlock?) {
        let url = Network.business + "/place/\(UserDefaults().object(forKey: UserDefaultKeys.placeID.rawValue) ?? 0)/"
        
        let params = [  "description": editedPlaceInfo.value.description as Any,
                        "instagram": editedPlaceInfo.value.instagram as Any,
                        "phone": editedPlaceInfo.value.phone as Any,
                        "website": editedPlaceInfo.value.website as Any,
                        "email": editedPlaceInfo.value.email as Any,
                        "working_hours": editedPlaceInfo.value.workingHours?.toJSONParams() as Any,
                        "business_lunch": tagsData.value.businessLaunchPrice,
                        "average_check": tagsData.value.averageBillPrice,
                        "tags": tagsData.value.tagIDs,
                        "images": [],
                        "remove_images": editedPlaceInfo.value.imageIDsToRemove
                    ]
        
        Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    switch json["code"].intValue {
                    case 0:
                        self.placeInfo = self.editedPlaceInfo.value
                        self.placeInfo.updated.value = true
                        
                        completion?(.ok, "")
                    default:
                        completion?(.error, json["message"].stringValue)
                    }
                    
                case .failure(_):
                    
                    let json = JSON(response.data as Any)
                    completion?(.fail, json["message"].stringValue)
                    
                }
        }
        
    }
}
