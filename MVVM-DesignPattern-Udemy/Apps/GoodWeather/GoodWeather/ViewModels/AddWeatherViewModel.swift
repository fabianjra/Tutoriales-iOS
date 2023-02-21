//
//  AddWeatherViewModel.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 20/2/23.
//

import Foundation

class AddWeatherViewModel {
    
    func addWeather(for city: String, completion: @escaping(WeatherViewModel) -> Void) {
        
        let url = Constants.getWeatherURL(city)
        let resource = Resource<WeatherResponse>(url: url) { data in
            
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode(WeatherResponse.self, from: data)
                return response
                
            }catch{
                Log.WriteCatchExeption(error: error)
                Utils.showAlertMessage("Error", message: error.localizedDescription)
                return nil
            }
        }
        
        //NOTA: Posiblemente en algunos casos pueda provocarse un error de "Transport Seccurity" llamado "finished with error".
        //Para solucionar eso:
        //1: Se agrega el info.plist la llave: "App Transport Security Settigns".
        //2: Dentro de la llave agregada, se agrega una subllave llamada: "Allow Arbitrary Loads".
        //3: Se pone en subllave con el valor "YES".
        Webservice().load(resource: resource) { result in
            
            if let result = result {
                
                let viewModel = WeatherViewModel(weather: result)
                
                completion(viewModel)
                
                Utils.showAlertMessage("Temperature response", message: "Temperature: \(viewModel.temperature.description)°, humidity: \(viewModel.weather.weather.humidity.description) and city: \(viewModel.city)")
            }
        }
    }//END: addWeather
}
