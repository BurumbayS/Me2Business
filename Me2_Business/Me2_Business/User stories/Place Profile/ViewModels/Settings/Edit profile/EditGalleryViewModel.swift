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
    
    var imageIndexesToRemove = [Int]()
    
    init(place: Place) {
        self.placeInfo = place
    }
    
    func selectImage(atIndex index: Int) {
        if let pos = imageIndexesToRemove.firstIndex(of: index) {
            imageIndexesToRemove.remove(at: pos)
        } else {
            imageIndexesToRemove.append(index)
        }
    }
    
    func removeImages() {
        for index in imageIndexesToRemove {
            placeInfo.imageIDs.remove(at: index)
            placeInfo.images.remove(at: index)
        }
        
        imageIndexesToRemove = []
        
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
                        
                        self.placeInfo.images.append(json["data"]["file"].stringValue)
                        self.placeInfo.imageIDs.append(json["data"]["id"].intValue)
                        
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
