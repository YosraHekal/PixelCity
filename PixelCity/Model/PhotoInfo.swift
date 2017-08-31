//
//  PhotoInfo.swift
//  PixelCity
//
//  Created by Minni K Ang on 2017-08-30.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation

struct PhotoInfo: Decodable {
    
    public private(set) var id: String!
    public private(set) var owner: String!
    public private(set) var secret: String!
    public private(set) var server: String!
    public private(set) var farm: Int!
    public private(set) var title: String?
    public private(set) var ispublic: Int!
    public private(set) var isfriend: Int!
    public private(set) var isfamily: Int!
}
