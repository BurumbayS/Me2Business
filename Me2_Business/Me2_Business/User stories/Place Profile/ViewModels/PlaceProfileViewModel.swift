//
//  PlaceProfileViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 2/27/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum PlaceProfilePage: String  {
    case info = "PlaceInfoCell"
    case menu = "PlaceMenuCell"
    case reviews = "PlaceReviewsCell"
    
    var cellID: String {
        return self.rawValue
    }
    
    func getCellClass() -> UICollectionViewCell.Type {
        switch self {
        case .info:
            return PlaceInfoCollectionViewCell.self
        case .menu:
            return PlaceMenuCollectionViewCell.self
        case .reviews:
            return PlaceReviewsCollectionViewCell.self
        }
    }
}

class PlaceProfileViewModel {
    var currentPage: Dynamic<Int>
    var pageToShow: Dynamic<PlaceProfilePage>
    var placeStatus: PlaceStatus
    var place: Place
    var placeJSON: JSON!
    
    var dataLoaded = false
    
    var isFollowed: Dynamic<Bool> = Dynamic(false)
    
    init() {
        place = Place(json: JSON())
        pageToShow = Dynamic(.info)
        currentPage = Dynamic(0)
        placeStatus = .registered
        
        currentPage.bind { [unowned self] (index) in
            self.pageToShow.value = PlaceStatus.registered.pages[index]
        }
    }
    
    func fetchData(completion: ResponseBlock?) {
        if dataLoaded { return }
        
        guard let placeID = UserDefaults().object(forKey: UserDefaultKeys.placeID.rawValue) as? Int else { return }
        
        let url = placeInfoURL + "\(placeID)/"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders())
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    self.placeJSON = json["data"]
                    self.place = Place(json: json["data"])
                    
                    self.getSubsidiaries(completion: completion)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completion?(.fail, "")
                }
        }
    }
    
    private func getSubsidiaries(completion: ResponseBlock?) {
        let url = placeInfoURL + "?branch=\(place.branch)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Network.getAuthorizedHeaders())
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    var subsidiaries = [Place]()
                    for item in json["data"]["results"].arrayValue {
                        subsidiaries.append(Place(json: item))
                    }
                    
                    self.place.subsidiaries = subsidiaries
                    self.dataLoaded = true
                    
                    completion?(.ok, "")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completion?(.fail, "")
                }
        }
    }
    
    func numberOfSections() -> Int {
        return (dataLoaded) ? 2 : 0
    }
    
    private let placeInfoURL = Network.core + "/place/"
}
