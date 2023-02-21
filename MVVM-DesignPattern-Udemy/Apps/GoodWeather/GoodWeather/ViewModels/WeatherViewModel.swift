//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 20/2/23.
//

class WeatherViewModel {
    let weather: WeatherResponse
    var temperature: Double
    
    init(weatherResponse: WeatherResponse) {
        self.weather = weatherResponse
        self.temperature = weatherResponse.weather.temperature
    }
    
    var city: String {
        return weather.cityName
    }
    
//    var temperature: Double {
//        return weather.weather.temperature
//    }
    
    
}
