//
//  MapVC
//  PixelCity
//
//  Created by Minni K Ang on 2017-08-29.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    @IBAction func centerMapBtnPressed(_ sender: Any) {
    }
    

}

extension MapVC: MKMapViewDelegate {
    
}
