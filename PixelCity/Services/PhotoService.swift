//
//  PhotoService.swift
//  PixelCity
//
//  Created by Minni K Ang on 2017-08-30.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PhotoService {
    static let instance = PhotoService()
    
    var photoInfoArray = [PhotoInfo]()
    var photoInfo: PhotoInfo?
    
    func getphotoInfoArray(forUrl url: String, completion: @escaping (_ status: Bool) -> ()) {
    
        Alamofire.request(url).responseJSON { (response) in
            if response.result.error == nil {
                guard let json = response.result.value as? Dictionary<String, Any> else { return }
                guard let photos = json["photos"] as? Dictionary<String, Any> else { return }
                guard let photo = photos["photo"] as? [Dictionary<String, Any>] else { return }
                
                for pic in photo {
                    let photoInfo = PhotoInfo(id: pic["id"] ?? "NA", owner: pic["owner"] ?? "NA", secret: pic["secret"] ?? "NA", server: pic["server"] ?? "NA", farm: pic["farm"] ?? "NA", title: pic["title"] ?? "NA", ispublic: pic["ispublic"] ?? "NA", isfriend: pic["isfriend"] ?? "NA", isfamily: pic["isfamily"] ?? "NA")
                    self.photoInfoArray.append(photoInfo)
                }
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
}
