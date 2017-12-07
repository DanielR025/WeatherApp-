//
//  WeatherCell.swift
//  SimpleWeatherApp
//
//  Created by Daniel Reicher on 08.07.17.
//  Copyright © 2017 Daniel Reicher. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var WeatherIcon: UIImageView!
    @IBOutlet weak var DayLbl: UILabel!
    @IBOutlet weak var WeatherType: UILabel!
    @IBOutlet weak var HighTmp: UILabel!
    @IBOutlet weak var LowTmp: UILabel!
    
    
    
    func configureCell(forecast: Forecast){
        
        LowTmp.text = forecast.lowTmp
        HighTmp.text = forecast.highTmp
        WeatherType.text = forecast.weathertype
        DayLbl.text = forecast.date
        WeatherIcon.image = UIImage(named: forecast.weathertype)
        
        
    }
    
    
    
    
    
    

    
}
