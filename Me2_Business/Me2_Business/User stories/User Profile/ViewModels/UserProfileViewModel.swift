//
//  UserProfileViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/24/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum UserProfileSection: String {
    case bio = "Био"
    case interests = "Интересы"
    case favourite_places = "Любимые места"
}

class UserProfileViewModel {
    var sections = [UserProfileSection]()
    
    var tagsExpanded = Dynamic(false)
    
    let userID: Int
    
    var chatRoom: Room!
    var userInfo: Dynamic<User>!
    var favouritePlaces: Dynamic<[Place]>!
    
    var presenterDelegate: ControllerPresenterDelegate!
    var parentVC: UserProfileViewController!
    
    var dataLoaded: Bool = false {
        didSet {
            if self.dataLoaded {
                self.sections = [.bio, .interests, .favourite_places]
            }
        }
    }
    
    init(userID: Int = 0) {
        self.userID = userID
    }
    
    func fetchData(completion: ResponseBlock?) {
        let url = Network.user + "/\(userID)/"

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    self.userInfo = Dynamic(User(json: json["data"]["user"]))
                    self.favouritePlaces = Dynamic(self.userInfo.value.favouritePlaces)

                    self.dataLoaded = true
                    completion?(.ok, "")

                case .failure(_ ):
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                }
        }
    }
}
