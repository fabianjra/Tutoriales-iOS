//
//  ServiceLayer.swift
//  WeatherAppMVVM
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation

class ServiceLayer {
    
    func fetchWeather(_ city: String) async throws -> WeatherResponseModel {
        
        let url = Constants.getWeatherURL(city)
        
        do {
            
            //Async -- Await funciona desde iOS15 en adelante.
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else{
                throw NetworkError.httpResponseError
            }
            
            if(httpResponse.statusCode > 299){
                throw NetworkError.statusCodeError
            }
            
            let decoder = JSONDecoder()
            
            do{
                //el valor "data" contiene los datos consultados.
                //Aqui trata de transformarlo con el decoder, al tipo de objeto que se esta esperando.
                let model = try decoder.decode(WeatherResponseModel.self, from: data)
                
                return model
            }catch{
                Log.WriteCatchExeption(error: error)
                throw NetworkError.couldNotDecodeData
            }
            
        } catch {
            throw NetworkError.generic
        }
    }
}
