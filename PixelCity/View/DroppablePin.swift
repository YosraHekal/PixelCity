//
//  DroppablePin.swift
//  PixelCity
//
//  Created by Minni K Ang on 2017-08-29.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}

