//
//  WeatherModel.swift
//  WeatherAppMVVM
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation

struct WeatherResponseModel: Decodable {
    let weather: [WeatherModel]
    let main: MainModel
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main = "main"
        case cityName = "name"
    }
}

struct WeatherModel: Decodable {
    let type: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case type = "main"
        case description
    }
}

struct MainModel: Decodable {
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}
