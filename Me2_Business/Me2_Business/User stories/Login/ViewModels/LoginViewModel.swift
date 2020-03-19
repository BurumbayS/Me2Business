//
//  LoginViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class LoginViewModel {
    func signIn(with email: String, and password: String, completion: ((RequestStatus, String) -> ())?) {
        let params = ["app": "BUSINESS", "username": email, "password": password]
        
        Alamofire.request(loginURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getHeaders())
            .responseJSON { (response) in
                switch response.result {
                case .success(let result):
                    
                    let json = JSON(result)
                    print(json)
                    
                    let code = json["code"].intValue
                    switch code {
                    case 0:
                        
                        let token = json["data"]["token"].stringValue
                        let id = json["data"]["user"]["id"].intValue
                        let placeID = json["data"]["place"]["id"].intValue
                        UserDefaults().set(token, forKey: UserDefaultKeys.token.rawValue)
                        UserDefaults().set(id, forKey: UserDefaultKeys.userID.rawValue)
                        UserDefaults().set(placeID, forKey: UserDefaultKeys.placeID.rawValue)
//                        UserDefaults().set(json["data"]["user"].rawString(), forKey: UserDefaultKeys.userInfo.rawValue)
                        
                        completion?(.ok, "")
                        
                    case 1:
                        
                        let message = json["message"].stringValue
                        completion?(.error, message)
                        
                    default:
                        break
                    }
                    
                case .failure(_):
                    let json = JSON(response.data as Any)
                    completion?(.fail, json["message"].stringValue)
                }
        }
    }
    
    let loginURL = Network.auth + "/authenticate/"
}
