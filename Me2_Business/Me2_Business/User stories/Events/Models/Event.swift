//
//  Event.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/28/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import SwiftyJSON
import Alamofire

enum DateType: String {
    case weekdays = "WEEKDAYS"
    case everyday = "EVERYDAY"
    case once = "ONCE"
    case weekends = "WEEKENDS"
    
    var title: String {
        switch self {
        case .weekends:
            return "По выходным"
        case .weekdays:
            return "По будням"
        case .everyday:
            return "Ежедневно"
        case .once:
            return "Один раз"
        }
    }
}

class Event {
    let id: Int
    var title: String!
    var description: String?
    var imageURL: String?
    var place: Place!
    var flagImage = UIImage(named: "unselected_flag")
    var eventType: String!
    var start: String!
    var end: String!
    var time_start: String?
    var time_end: String?
    var date_type: DateType!
    var tags = [Tag]()
    var favourite_count: Int?
    var created_at: String?
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["name"].stringValue
        description = json["description"].stringValue
        imageURL = json["image"].stringValue
        eventType = json["event_type"]["name"].stringValue
        place = Place(json: json["place"])
        date_type = DateType(rawValue: json["date_type"].stringValue)
        start = json["start"].stringValue
        end = json["end"].stringValue
        time_start = json["time_start"].stringValue
        time_end = json["time_end"].stringValue
        favourite_count = json["favourite_count"].intValue
        created_at = json["created_at"].stringValue
        
        for item in json["tags"].arrayValue {
            tags.append(Tag(json: item))
        }
    }
    
    func getTime() -> String {
        if date_type == .once {
            return "\(formatDate(str: start))-\(formatDate(str: end))"
        }
        
        var start = time_start ?? ""
        var end = time_end ?? ""
        
        if start != "" && end != "" {
            start.removeLast(3)
            end.removeLast(3)
            
            return date_type.title + " " + start + "-" + end
        }
        
        if end != "" {
            end.removeLast(3)

            return date_type.title + " до " + end
        }
        
        if start != "" {
            start.removeLast(3)
            
            return date_type.title + " с " + start
        }
        
        return date_type.title
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        guard let date = dateFormatter.date(from: created_at ?? "") else { return "" }
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    private func formatDate(str: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = formatter.date(from: str)
        
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date!)
    }
    
    func generateShareInfo() -> String {
        var message = ""
        
        message =   "\(title!) в \(place.name ?? "")\n" +
                    "\(getTime())" +
                    "\n" +
                    "\n" +
                    "Для просмотра подробной информации откройте в приложении Me2" +
                    "\n" +
                    "\n" +
                    "Доступно бесплатно в:\n" +
                    "App store: www.me2.kz\n" +
                    "Google play: www.me2.kz"
        
        return message
    }
}
