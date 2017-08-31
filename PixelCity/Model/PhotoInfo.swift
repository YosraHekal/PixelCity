//
//  PhotoInfo.swift
//  PixelCity
//
//  Created by Minni K Ang on 2017-08-30.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation

struct PhotoInfo {
    
    var id: Any!
    var owner: Any!
    var secret: Any!
    var server: Any!
    var farm: Any!
    var title: Any!
    var ispublic: Any!
    var isfriend: Any!
    var isfamily: Any!
    
    init(id: Any, owner: Any, secret: Any, server: Any, farm: Any, title: Any, ispublic: Any, isfriend: Any, isfamily: Any) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
    }
}
