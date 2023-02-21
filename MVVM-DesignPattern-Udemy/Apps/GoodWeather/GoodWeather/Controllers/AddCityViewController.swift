//
//  AddCityViewController.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 16/2/23.
//

import UIKit

protocol addWeatherDelegate {
    func addWeatherDidSave(viewModel: WeatherViewModel)
}

class AddCityViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    // -- MARK: Variables
    
    private var addWeatherVM = AddWeatherViewModel()
    var delegate: addWeatherDelegate?
    
    
    // -- MARK: Buttons
    
    @IBAction func addCityButtonPressed() {
        
        if cityNameTextField.text?.isEmptyOrWhitespace() == true {
            Utils.showAlertMessage("Empty space", message: "Please write a city name in the blank space")
        } else {
            
            let cityName = cityNameTextField.text! //Its alrady validated
            
            addWeatherVM.addWeather(for: cityName) { weatherVM in
                self.delegate?.addWeatherDidSave(viewModel: weatherVM)
                
                Utils.showAlertMessage("Added", message: "Succesfully added the new city weather") { _ in
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @IBAction func closeButtonPressed() {
        self.dismiss(animated: true)
    }
}
