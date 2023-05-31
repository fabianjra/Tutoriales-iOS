//
//  WeatherViewModel.swift
//  WeatherAppMVVM
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {

    @Published var weatherVM = WeatherVM()
    
    func fetchWeather(_ city: String) async {
        
        let service = ServiceLayer()
        
        do {
            
            let model = try await service.fetchWeather(city)
            
            //Detached significa que no va a ejecutarse sobre el Main Thread, sino en otro.
            Task.detached {
                //Ingreso al background thread

                await MainActor.run {
                    self.weatherVM.title = model.weather.first?.type ?? "NO DATA"
                    self.weatherVM.description = model.weather.first?.description ?? "NO DATA"
                    self.weatherVM.temperature = model.main.temperature.description
                    self.weatherVM.timeZone = model.cityName
                }
            }
        } catch {
            Log.WriteCatchExeption(error: error)
        }
    }
}

struct WeatherVM {
    var title: String = ""
    var description: String = ""
    var temperature: String = ""
    var timeZone: String = ""
}
