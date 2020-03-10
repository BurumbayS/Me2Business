//
//  EditProfileViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/3/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Foundation

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
    
    let placeInfo: Place
    let editedPlaceInfo: Place
    let tagsData = TagsDataToSave()
    
    init(place: Place) {
        self.placeInfo = place
        self.editedPlaceInfo = place
        self.tagsData.placeTagNames = place.tags
        self.tagsData.averageBillPrice = place.averageCheck
        self.tagsData.businessLaunchPrice = place.businessLunch
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
}
