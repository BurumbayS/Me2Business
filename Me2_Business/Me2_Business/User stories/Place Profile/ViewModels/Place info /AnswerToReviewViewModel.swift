//
//  AnswerToReviewViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/13/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class AnswerToReviewViewModel {
    let baseReview: Review
    
    var reviewAnswerHandler: VoidBlock?
    
    init(baseReview: Review, onAnswerToReview: VoidBlock?) {
        self.baseReview = baseReview
        self.reviewAnswerHandler = onAnswerToReview
    }
    
    func answerToReview(withText text: String, completion: ResponseBlock?) {
        let url = Network.core + "/review/"
        let params = ["base_review": self.baseReview.id,
                      "place": UserDefaults().object(forKey: UserDefaultKeys.placeID.rawValue) ?? 0,
                      "body": text,
                      "rating": self.baseReview.rating] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    switch json["code"].intValue {
                    case 0:
                        self.reviewAnswerHandler?()
                        completion?(.ok, "")
                    default:
                        completion?(.error, json["message"].stringValue)
                    }
                    
                case .failure(let error):
                    print(error)
                    completion?(.error, "")
                }
        }
    }
}
