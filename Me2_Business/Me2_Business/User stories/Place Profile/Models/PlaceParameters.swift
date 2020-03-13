//
//  PlaceParameters.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON
import Alamofire

enum PlaceStatus {
    case registered
    case not_registered
    
    var pages: [PlaceProfilePage] {
        switch self {
        case .registered:
            return [PlaceProfilePage.info, .menu, .reviews]
        case .not_registered:
            return [PlaceProfilePage.info, .reviews]
        }
    }
    
    var pagesTitles: [String] {
        switch self {
        case .registered:
            return ["Инфо","Меню","Отзывы"]
        case .not_registered:
            return ["Инфо", "Отзывы"]
        }
    }
}

struct Menu {
    enum MenuType: String {
        case main = "MAIN"
        case bar = "BAR"
        case additional = "EXTRA"
        
        var title: String {
            switch self {
            case .main:
                return "Основное меню"
            case .bar:
                return "Барное меню"
            case .additional:
                return "Дополнительное меню"
            }
        }
        
        var image: UIImage {
            switch self {
            case .main:
                return UIImage(named: "main_menu_icon")!
            case .bar:
                return UIImage(named: "bar_menu_icon")!
            case .additional:
                return UIImage(named: "main_menu_icon")!
            }
        }
    }
    
    var id: Int
    var file: String
    var menu_type: MenuType
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.file = json["file"].stringValue
        
        self.menu_type = MenuType(rawValue: json["menu_type"].stringValue) ?? MenuType.main
    }
}

struct RoomInfo {
    var uuid: String
    var usersCount: Int
    var avatars: [String]
    
    init(json: JSON) {
        uuid = json["uuid"].stringValue
        usersCount = json["users_count"].intValue
        
        avatars = [String]()
        for item in json["avatars"].arrayValue {
            avatars.append(item.stringValue)
        }
    }
}

enum WeekDayName: String {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var localShortTitle: String {
        switch self {
        case .sunday:
            return "Вс"
        case .monday:
            return "Пн"
        case .tuesday:
            return "Вт"
        case .wednesday:
            return "Ср"
        case .thursday:
            return "Чт"
        case .friday:
            return "Пт"
        case .saturday:
            return "Сб"
        }
    }
    
    var localTitle: String {
        switch self {
        case .sunday:
            return "Воскресенье"
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        }
    }
}

class WeekDay {
    var name: WeekDayName
    var title: String
    var start: String
    var end: String
    var works: Bool
    var dayNnight: Bool
    
    var isWeekend: Bool {
        switch name {
        case .sunday, .saturday:
            return true
        default:
            return false
        }
    }
    
    var order: Int {
        switch name {
        case .sunday:
            return 7
        case .monday:
            return 1
        case .tuesday:
            return 2
        case .wednesday:
            return 3
        case .thursday:
            return 4
        case .friday:
            return 5
        case .saturday:
            return 6
        }
    }
    
    init(title: String, json: JSON) {
        self.title = title
        self.name = WeekDayName(rawValue: title)!
        self.start = json["start"].stringValue
        self.end = json["end"].stringValue
        self.works = json["works"].boolValue
        self.dayNnight = json["day_and_night"].boolValue
    }
    
    func isEgual(to weekDay: WeekDay) -> Bool {
        if self.start == weekDay.start && self.end == weekDay.end {
            return true
        }
        
        return false
    }
}

class WorkingHours {
    var weekDays = [WeekDay]()
    
    init(json: JSON) {
        for item in json.dictionaryValue {
            let weekDay = WeekDay(title: item.key, json: item.value)
            weekDays.append(weekDay)
        }
    }
    
    func toJSONParams() -> Parameters {
        var params = Parameters()
        
        for weekDay in weekDays {
            params[weekDay.name.rawValue] = ["start_s": 0,
                                             "end_s": 0,
                                             "start": weekDay.start,
                                             "end": weekDay.end,
                                             "works": weekDay.works,
                                             "day_and_night": weekDay.dayNnight
                                            ]
//            let item: Parameters =  ["\(weekDay.name.rawValue)": ["start_s": 0,
//                                                      "end_s": 0,
//                                                      "start": weekDay.start,
//                                                      "end": weekDay.end,
//                                                      "works": weekDay.works,
//                                                      "day_and_night": weekDay.dayNnight
//                                                     ]
//                        ]
            
//            jsonParameters.append(item)
        }
        
        return params
    }
}

class PlaceImage {
    let id: Int
    let url: String
    
    init(id: Int, url: String) {
        self.id = id
        self.url = url
    }
}
