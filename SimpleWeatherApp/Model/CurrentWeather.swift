//
//  CurrentWeather.swift
//  SimpleWeatherApp
//
//  Created by Daniel Reicher on 11.06.17.
//  Copyright © 2017 Daniel Reicher. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName:String!
    var _date:String!
    var _weatherType:String!
    var _currentTemp:Double!
    
    var cityName:String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var date:String{
        if _date == nil{
            _date = ""
        }
        
        
        //Datum Obejekt erstellen
        let dateFormatter = DateFormatter()
        // Date Aussehen bestimmen
        dateFormatter.dateStyle = .medium
        // mit oder ohne Zeit (Standarteinstellung mit Zeit)
        dateFormatter.timeStyle = .none
        //Konstatne mit aktuellem Datum erstellen und Einstellungen vom dateFormater zuweisen
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    
    
    
    var weatherType:String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp:Double{
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
        
    }
    
    //MARK: Download JSON
    
    func downloadWeatherDetails(completed : @escaping DownloadComplete){
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let name = dict["name"] as? String{
                    self._cityName = name
                   
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main
                    }
                }
                if let currenttemp = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = currenttemp["temp"] as? Double{
                        let kelvinToCelsius = temp - 273.15
                        let roundedValue = Double(round(10*kelvinToCelsius)/10)
                        self._currentTemp = roundedValue
                        
                        
                    }
                }
            }
            completed()
        }
        
    }
    
}
