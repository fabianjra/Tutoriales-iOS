//
//  WeatherResponse.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 20/2/23.
//

import  Foundation

struct WeatherResponse: Decodable {
    let weather: Weather
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case weather = "main"
        case cityName = "name"
    }
}

struct Weather: Decodable {
    let temperature: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
    }
}
