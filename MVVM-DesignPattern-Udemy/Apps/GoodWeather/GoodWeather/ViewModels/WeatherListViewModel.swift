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
    
    //Get a Model at a particular location.
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherCollectionViewModel[index]
    }
}
