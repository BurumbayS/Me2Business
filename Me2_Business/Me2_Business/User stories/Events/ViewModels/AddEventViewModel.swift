//
//  AddEventViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/31/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum AddEventSectionType {
    case mainInfo
    case date
    case time
    case price
    case tags
}

class EventData {
    var name: String!
    var description: String!
    var event_type: Int!
    var place: Int!
    var start: String?
    var end: String?
    var time_start: String?
    var time_end: String?
    var price_min: Int!
    var price_max: Int!
    var dateType: DateType!
    var image: UIImage!
    var tags: [Int] = []
    
    func getParams() -> Parameters {
        var params = Parameters()
        
        params["name"] = name
        params["description"] = description
        params["event_type"] = event_type
        params["place"] = 5
        if start != nil { params["start"] = start }
        if end != nil { params["end"] = end }
        if time_start != nil { params["time_start"] = time_start }
        if time_end != nil { params["time_end"] = time_end }
        params["price_min"] = price_min
        params["price_max"] = price_max
        params["date_type"] = dateType.rawValue
        params["tags"] = tags
        
        return params
    }
}

class AddEventViewModel {
    let sections = [AddEventSectionType.mainInfo, .date, .time, .price, .tags]
    let eventData = EventData()
    
    func addNewEvent() {
        var params = eventData.getParams()
        
        uploadImage(image: eventData.image) { [weak self] (id) in
            params["image"] = id
            self?.createEvent(with: params)
        }
    }
    
    private func createEvent(with params: Parameters) {
        let url = Network.business + "/event/"
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                case .failure(_):
                    print(JSON(response.data as Any))
                }
        }
    }
    
    private func uploadImage(image: UIImage, completion: ((Int) -> ())?) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let url = Network.host + "/image/"
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "file", fileName: "image.jpeg", mimeType: "image/jpeg")
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: Network.getAuthorizedHeaders()) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    let json = JSON(response.data as Any)
                    completion?(json["data"]["id"].intValue)
                    
                }
                
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completion?(0)
            }
        }
    }
}
