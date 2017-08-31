//
//  RetrieveWeatherData.swift
//  MyDailyPackingPlanner
//
//  Created by Minni K Ang on 2017-08-15.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}

class RetrieveWeatherData {
    
    var urlComponents = URLComponents()
    let session = URLSession.shared
    
    let locLat = URLQueryItem(name: "lat", value: "\(latitude)")
    let locLon = URLQueryItem(name: "lon", value: "\(longitude)")
    let units = URLQueryItem(name: "units", value: "metric")
    let apiKey = URLQueryItem(name: "APPID", value: APIKEY)
    
    init() {
        urlComponents.scheme = "http"
        urlComponents.host = "api.openweathermap.org"
    }
    
    func createForecastURL() -> URL? {
        urlComponents.path = "/data/2.5/forecast/daily"
        urlComponents.queryItems = [locLat, locLon, units, apiKey]
        return urlComponents.url
    }
}

