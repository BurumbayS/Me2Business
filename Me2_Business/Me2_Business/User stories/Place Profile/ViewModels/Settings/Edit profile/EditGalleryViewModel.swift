//
//  EditGalleryViewModel.swift
//  Me2_Business
//
//  Created by Sanzhar Burumbay on 3/10/20.
//  Copyright © 2020 AVSoft. All rights reserved.
//

import Alamofire
import SwiftyJSON

class EditGalleryViewModel {
    var placeInfo: Place!
    
    var isEditing = false
    
    var imageIDsToRemove = [Int]()
    
    init(place: Place) {
        self.placeInfo = place
    }
    
    func selectImage(atIndexPath indexPath: IndexPath) {
        let id = placeInfo.imageList[indexPath.row].id
        
        if let pos = imageIDsToRemove.firstIndex(of: id) {
            imageIDsToRemove.remove(at: pos)
        } else {
            imageIDsToRemove.append(id)
        }
    }
    
    func removeImages() {
        for id in imageIDsToRemove {
            if let index = placeInfo.imageList.firstIndex(where: { $0.id == id }) {
                placeInfo.imageList.remove(at: index)
            }
            
            placeInfo.imageIDsToRemove.append(id)
        }
        
        imageIDsToRemove = []
        
        isEditing = false
    }
    
    func uploadImage(image: UIImage?, completion: ResponseBlock?) {
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else {
            completion?(.error, "Ошибка загрузки")
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
                    switch json["code"].intValue {
                    case 0:
                        
                        self.placeInfo.imageList.append(PlaceImage(id: json["data"]["id"].intValue, url: json["data"]["file"].stringValue))
                        
                        completion?(.ok, "")
                        
                    default:
                        completion?(.error, "Ошибка загрузки")
                    }
                    
                }
                
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completion?(.fail, "Ошибка загрузки")
            }
        }
    }
}
