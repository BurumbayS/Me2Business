//
//  SetNewPassViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/23/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class SetNewPassViewModel {
    
    func updatePass(with value: String, completion: ((RequestStatus, String) -> ())?) {
        let params = ["password" : value]
        
        Alamofire.request(updatePassURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders())
            .responseJSON { (response) in
                switch response.result {
                case .success(let result):
                    
                    let json = JSON(result)
                    print(json)
                    
                    let code = json["code"].intValue
                    switch code {
                    case 0:

                        completion?(.ok, "")

                    case 1:

                        let message = json["message"].stringValue
                        completion?(.error, message)

                    default:
                        break
                    }
                    
                case .failure(let error):
                    print(error)
                    completion?(.fail, "")
                }
        }
    }
    
    let updatePassURL = Network.user + "/new_password/"
}
