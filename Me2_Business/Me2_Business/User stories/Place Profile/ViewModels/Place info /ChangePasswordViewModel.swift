//
//  ChangePasswordViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/4/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ChangePasswordViewModel {
    func updatePassword(password: String, with newPass: String, completion: ResponseBlock?) {
        let params = ["old_password": password, "new_password": newPass]
        
        Alamofire.request(updatePassURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    switch json["code"].intValue{
                    case 0:
                        completion?(.ok, "")
                    case 1:
                        completion?(.error, json["message"].stringValue)
                    default:
                        break
                    }
                    
                case .failure( _):
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                }
        }
    }
    
    let updatePassURL = Network.user + "/change_password/"
}
