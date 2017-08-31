//
//  Weather.swift
//  MyDailyPackingPlanner
//
//  Created by Minni K Ang on 2017-08-15.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation

extension Date {
    
    func myDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "EEEE, d MMM YYYY"
        return dateFormatter.string(from: self)
    }
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

struct Weather {
    
    var date: String
    var day: String
    var timestamp: Double
    var weatherType: String
    var weatherImage: String
    var tempMin: String
    var tempMax: String
    var windSpeed: String
    
    init(json: [String: Any]) throws {
        guard let date = json["dt"] as? Double
            else {
                print("Forecast date not available")
                throw SerializationError.missing("date")
        }
        
        guard let weather = json["weather"] as? [[String: Any]],
            let weatherImage = weather[0]["main"] as? String,
            let weatherType = weather[0]["description"] as? String
            else {
                print("Weather info not available")
                throw SerializationError.missing("weather")
        }
        
        guard let temp = json["temp"] as? [String: Any],
            let tempMin = temp["min"] as? Double,
            let tempMax = temp["max"] as? Double
            else {
                print("Temperature not available")
                throw SerializationError.missing("temp")
        }
        
        guard let windSpeed = json["speed"] as? Double
            else {
                print("WindSpeed not available")
                throw SerializationError.missing("windspeed")
        }
        
        self.timestamp = date
        
        let unixDate = Date(timeIntervalSince1970: date)
        self.date = unixDate.myDateFormat()
        self.day = unixDate.dayOfTheWeek()
        
        self.weatherImage = weatherImage.capitalized
        self.weatherType = weatherType.capitalized
        self.tempMin = String(format: "%.1f", tempMin)
        self.tempMax = String(format: "%.1f", tempMax)
        self.windSpeed = String(format: "%.0f", windSpeed * 3.6)
    }
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}


