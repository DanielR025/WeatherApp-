//
//  Constants.swift
//  SimpleWeatherApp
//
//  Created by Daniel Reicher on 11.06.17.
//  Copyright © 2017 Daniel Reicher. All rights reserved.
//

import Foundation



let APP_KEY = "93df7e1685288b34167b29b30c704ab2"

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=93df7e1685288b34167b29b30c704ab2"

let CURRENT_WEATHER_URL2 = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=93df7e1685288b34167b29b30c704ab2"




typealias DownloadComplete = () -> ()





