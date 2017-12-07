//
//  Location.swift
//  SimpleWeatherApp
//
//  Created by Daniel Reicher on 10.07.17.
//  Copyright © 2017 Daniel Reicher. All rights reserved.
//

import CoreLocation

//Singleton Class for GPS

class Location {
    static var sharedInstance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}

