//
//  PhotoService.swift
//  PixelCity
//
//  Created by Minni K Ang on 2017-08-30.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation
import Alamofire

class PhotoService {
    static let instance = PhotoService()
    
    var photoInfoArray = [PhotoInfo]()
    var photoInfo: PhotoInfo?
    
    func getphotoInfoArray(forUrl url: String, completion: @escaping (_ status: Bool) -> ()) {
    
        Alamofire.request(url).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    
                    
                    self.photoInfoArray = try JSONDecoder().decode([PhotoInfo].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
}
