//
//  ChatTabViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 1/6/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ChatTabViewModel {
    
    var chatsList = [Room]()
    
    var searchResults = [Room]()
    var searchActivated = false
    
    func getChatList(completion: ResponseBlock?) {
        Alamofire.request(chatsListURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders()).validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    self.chatsList = []
                    for item in json["data"]["results"].arrayValue {
                        self.chatsList.append(Room(json: item))
                    }
                    
                    completion?(.ok, "")
                    
                case .failure(_ ):
                    print(JSON(response.data as Any))
                    completion?(.fail, "")
                }
        }
    }
    
    func searchChat(with substr: String, completion: VoidBlock?) {
        searchResults = []
        
        chatsList.forEach { (room) in
            if room.getSecondParticipant().username.lowercased().contains(substr.lowercased()) {
                searchResults.append(room)
            }
        }
        
        completion?()
    }
    
    let chatsListURL = Network.chat + "/room/"
}
