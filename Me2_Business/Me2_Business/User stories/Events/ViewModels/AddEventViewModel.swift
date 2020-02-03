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
    let eventData = EventData()
    
    func addNewEvent(completion: ResponseBlock?) {
        guard eventData.requiredFieldsFilled() else {
            completion?(.error, "Заполните все необходимые поля")
            return
        }
        
        var params = eventData.getParams()
        
        uploadImage(image: eventData.image) { [weak self] (id) in
            params["image"] = id
            self?.createEvent(with: params, completion: completion)
        }
    }
    
    private func createEvent(with params: Parameters, completion: ResponseBlock?) {
        let url = Network.business + "/event/"
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    switch json["code"].intValue {
                    case 0:
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
    
    private func uploadImage(image: UIImage?, completion: ((Int) -> ())?) {
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        
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
