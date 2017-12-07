//
//  Forecast.swift
//  SimpleWeatherApp
//
//  Created by Daniel Reicher on 06.07.17.
//  Copyright © 2017 Daniel Reicher. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    
    var _date:String!
    var _weathertype:String!
    var _highTmp:String!
    var _lowTmp:String!
    
    
    var date:String{
        if _date == nil{
            _date = ""
        }
    return _date
    }
    
    var weathertype:String{
        if _weathertype == nil{
            _weathertype = ""
        }
        return _weathertype
    }
    
    var highTmp:String{
        if _highTmp == nil{
            _highTmp = ""
        }
        return _highTmp
    }
    
    var lowTmp:String{
        if _lowTmp == nil{
            _lowTmp = ""
        }
        return _lowTmp
    }
    
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double{
                let kelvinToCelsius = min - 273.15
                let roundedValue = Double(round(10*kelvinToCelsius)/10)
                self._lowTmp = "\(roundedValue)C°"
            }
            if let max = temp["max"] as? Double {
                let kelvinToCelsius = max - 273.15
                let roundedValue = Double(round(10*kelvinToCelsius)/10)
                self._highTmp = "\(roundedValue)C°"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weathertype = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixVonvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self._date = unixVonvertedDate.dayOftheWeek()
        }

    }
    
    
    
    
}




extension Date {
    func dayOftheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
}






