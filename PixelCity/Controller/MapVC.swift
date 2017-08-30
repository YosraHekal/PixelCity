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
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var revealView: UIView!
    @IBOutlet weak var revealViewHeight: NSLayoutConstraint!
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()

    let regionRadius: Double = 1000
    var screenSize = UIScreen.main.bounds
    
    var spinner: UIActivityIndicatorView?
    var progressLbl:UILabel?
    
    var flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        addDoubleTap()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: PHOTO_CELL)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        if collectionView != nil {
            revealView.addSubview(collectionView!)
        }
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }
    
    func addSwipeDown() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hideBottomView))
        swipeDown.direction = .down
        revealView.addGestureRecognizer(swipeDown)
    }
    
    func addSpinner() {
        spinner  = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width / 2) - ((spinner?.frame.width)! / 2), y: 150)
        spinner?.activityIndicatorViewStyle = .whiteLarge
        spinner?.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        spinner?.startAnimating()
        collectionView?.addSubview(spinner!)
    }
    
    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }
    
    func addProgressLbl() {
        progressLbl = UILabel()
        progressLbl?.frame = CGRect(x: (screenSize.width / 2) - 120, y: 175, width: 240, height: 40)
        progressLbl?.font = UIFont(name: "Avenir Next", size: 18)
        progressLbl?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        progressLbl?.textAlignment = .center
        progressLbl?.text = "Loading ..."
        collectionView?.addSubview(progressLbl!)
    }
    
    func removeProgressLbl() {
        if progressLbl != nil {
            progressLbl?.removeFromSuperview()
        }
    }
    
    @objc func hideBottomView() {
        showBottomView(show: false)
    }
    
    func showBottomView(show: Bool) {
        if show == true {
            revealViewHeight.constant = 300
        } else {
            revealViewHeight.constant = 1
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
     }
    
    func getPhotos(forAnnotation annotation: DroppablePin) -> String {
        return "\(FLICKR_URL)&content_type=1&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=\(regionRadius/1000)&per_page=20&format=json&nojsoncallback=1"
    }
    
    @IBAction func centerMapBtnPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: DROPPED_PIN)
        pinAnnotation.pinTintColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        removePin()
        removeSpinner()
        removeProgressLbl()
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: DROPPED_PIN)

        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
        self.showBottomView(show: true)
        addSwipeDown()
        addSpinner()
        addProgressLbl()
        print(getPhotos(forAnnotation: annotation))
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}

extension MapVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PHOTO_CELL, for: indexPath) as? PhotoCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
