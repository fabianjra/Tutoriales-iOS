//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 20/2/23.
//

//NOTE: This VM controls the entire screen and it's responsable for providing an array of WeatherViewModels to the Controller, so it can be displayed.
class WeatherListViewModel {
    
    private var weatherCollectionViewModel = [WeatherViewModel]()
    
    //This function allows this VM, to add a new item to its own collection.
    func addWeatherViewModel(_ weatherVM: WeatherViewModel) {
        weatherCollectionViewModel.append(weatherVM)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherCollectionViewModel.count
    }
    
    func getWeatherList() -> [WeatherViewModel] {
        return weatherCollectionViewModel
    }
    
    //Get a Model at a particular location.
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherCollectionViewModel[index]
    }
    
    func updateUnit(to unit: Unit) {
        switch unit {
        case .celcius:
            toCelcius()
            
        case .farenheit:
            toFarenheit()
        }
    }
    
    private func toCelcius() {
        
        //Furmula to convert from Farenheit to Celcius
        weatherCollectionViewModel = weatherCollectionViewModel.map { WeatherViewModel in
            let weatherVM = WeatherViewModel
            weatherVM.temperature = (weatherVM.temperature - 32) * 5 / 9
            return weatherVM
        }
    }
    
    private func toFarenheit() {
        
        //Furmula to convert from Celcius to Farenheit
        weatherCollectionViewModel = weatherCollectionViewModel.map { WeatherViewModel in
            let weatherVM = WeatherViewModel
            weatherVM.temperature = (weatherVM.temperature * 9 / 5) + 32
            return weatherVM
        }
    }
}
