//
//  WeatherListViewModelTests.swift
//  GoodWeatherTests
//
//  Created by Fabian Josue Rodriguez Alvarez on 24/2/23.
//

import XCTest

@testable import GoodWeather

final class WeatherListViewModelTests: XCTestCase {
    
    private var weatherListVM: WeatherListViewModel!

    override func setUp() {
        super.setUp()
        
        self.weatherListVM = WeatherListViewModel()
        
        //En los TEST hay que hacer pruebas logicas, para eso hacemos test de la logica de negocios dentro de la clase instanciada.
        //Para poder hacer test de "toCelcius" o "toFarenheit", primero se debe llenar un modelo para trabajr con esos datos.
        
        //En celcius, para convertir a farenheit
        let weather1 = Weather(temperature: .zero, humidity: .zero)
        let weatherResponse1 = WeatherResponse(weather: weather1, cityName: "Houston")
        let weatherViewModel1 = WeatherViewModel(weatherResponse: weatherResponse1)
        
        //En celcius, para convertir a farenheit
        let weather2 = Weather(temperature: 22.2222, humidity: .zero)
        let weatherResponse2 = WeatherResponse(weather: weather2, cityName: "Houston")
        let weatherViewModel2 = WeatherViewModel(weatherResponse: weatherResponse2)
        
        //Add the celcius units:
        self.weatherListVM.addWeatherViewModel(weatherViewModel1)
        self.weatherListVM.addWeatherViewModel(weatherViewModel2)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    //Test para comprobar que los grados se estan conviertiendo correctamente
    func test_should_be_able_to_convert_to_farenheit() {

        //If convert 0 celcius to farenheit, should be: 32.0
        //If convert 22.2222 farenheit to celcius, should be: 72.0
        let farenheitTemperatures = [32.0, 72.0]
        
        self.weatherListVM.updateUnit(to: .farenheit)
        
        for (index, vm) in self.weatherListVM.getWeatherList().enumerated() {
            
            //Se redondean para que la comparacion sea mas exacta y sea success
            let item = round(vm.temperature)
            let compareTo = round(farenheitTemperatures[index])
            
            XCTAssertEqual(item, compareTo)
        }
    }

}
