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

class AddEventViewModel {
    let sections = [AddEventSectionType.mainInfo, .date, .time, .price, .tags]
    let eventData: EventData
    
    let eventAdditionHandler: ((Event) -> ())?
    let eventChangesType: EventChangesType
    
    var eventID: Int = 0
    
    init(event: Event? = nil, eventChangesType: EventChangesType, onEventAdded: ((Event) -> ())?) {
        eventAdditionHandler = onEventAdded
        
        self.eventChangesType = eventChangesType
        eventData = EventData(changesType: eventChangesType)
        
        if let event = event {
            eventID = event.id
            eventData.copyFrom(event: event)
        }
    }
    
    func editEvent(completion: ResponseBlock?) {
        guard eventData.requiredFieldsFilled() else {
            completion?(.error, "Заполните все необходимые поля")
            return
        }
        
        var params = eventData.getParams()
        
        uploadImage(image: eventData.image) { [weak self] (id) in
            if let id = id { params["image"] = id }
            self?.updateEvent(with: params, completion: completion)
        }
    }
    
    private func updateEvent(with params: Parameters, completion: ResponseBlock?) {
        let url = (eventChangesType == .create) ? Network.business + "/event/" : Network.business + "/event/\(eventID)/"
        let method: HTTPMethod = (eventChangesType == .create) ? .post : .put
        
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    switch json["code"].intValue {
                    case 0:
                        let event = Event(json: json["data"])
                        self.eventAdditionHandler?(event)
                        
                        completion?(.ok, "")
                    default:
                        completion?(.error, json["message"].stringValue)
                    }
                    
                case .failure(_):
                    let json = JSON(response.data as Any)
                    if json["code"].intValue == 1 {
                        completion?(.error, json["message"].stringValue)
                    } else {
                        completion?(.fail, "")
                    }
                }
        }
    }
    
    private func uploadImage(image: UIImage?, completion: ((Int?) -> ())?) {
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else {
            completion?(nil)
            return
        }
        
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
