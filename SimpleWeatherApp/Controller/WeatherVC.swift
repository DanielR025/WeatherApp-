//
//  WeatherVC.swift
//  SimpleWeatherApp
//
//  Created by Daniel Reicher on 19.05.17.
//  Copyright © 2017 Daniel Reicher. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {

    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var DegreeLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    @IBOutlet weak var WeatherLbl: UILabel!
    @IBOutlet weak var WeatherImageLbl: UIImageView!
    @IBOutlet weak var TableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationAuthStatus()
        

        TableView.delegate = self
        TableView.dataSource = self
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI()
            }
            
        }

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    
    
    
    // Forecast downloaden und dem Array hinzufügen
    
    func downloadForecastData(completed : @escaping DownloadComplete){
        Alamofire.request(CURRENT_WEATHER_URL2).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.TableView.reloadData()
                }
            }
            completed()
        }
    }

    
    
    func updateMainUI(){
        DateLbl.text = currentWeather.date
        
        DegreeLbl.text = "\(currentWeather.currentTemp)C°" //Convert Double to String
        
        WeatherLbl.text = currentWeather.weatherType
        
        LocationLbl.text = currentWeather.cityName
        
        WeatherImageLbl.image = UIImage(named: currentWeather.weatherType)
        
    }
    
    
    //MARK: Forecast TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    
    
    // Forecasts vom Array den Cells hinzufügen
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
        
    }
    

    
    
   

}

