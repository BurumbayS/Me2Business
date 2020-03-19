//
//  FeedbackViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class FeedbackViewModel {
    func sendFeedback(withText text: String, completion: ResponseBlock?) {
        
        let url = Network.core + "/feedback/"
        let params: [String: String] = ["text": text]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    let code = json["code"].intValue
                    switch code {
                    case 0:
                        completion?(.ok, "")
                    default:
                        completion?(.error, json["message"].stringValue)
                    }
                    
                case .failure(_ ):
                    print("error = \(JSON(response.data as Any))")
                    completion?(.fail, "")
                }
        }
    }
}
