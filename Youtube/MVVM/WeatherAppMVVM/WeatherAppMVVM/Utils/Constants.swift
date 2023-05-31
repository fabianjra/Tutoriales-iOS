//
//  Constants.swift
//  WeatherAppMVVM
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation

class Constants {
    
    static let unit = "unit"
    
    static func getWeatherURL(_ cityName: String) -> URL {
        
        //Get the default settings for temperature
        let userDefaults = UserDefaults.standard
        let unit = (userDefaults.value(forKey: Constants.unit) as? String) ?? "imperial"
        
        let apiKey = "4b04a0477518e155d94c9a37678059bb"
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName.escaped())&appid=\(apiKey)&units=\(unit)"
        
        //let final = "https://api.openweathermap.org/data/2.5/weather?q=boston&appid=4b04a0477518e155d94c9a37678059bb&units=imperial"
        
        return URL(string: weatherURL)!
    }
}
