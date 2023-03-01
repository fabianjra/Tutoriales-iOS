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
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    private var addWeatherVM = AddWeatherViewModel()
    var delegate: addWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityNameTextField.delegate = self
    }
    
    
    // MARK: Buttons
    
    @IBAction func addCityButtonPressed() {
        
        if cityNameTextField.text?.isEmptyOrWhitespace() == true {
            Utils.showAlertMessage("Empty space", message: "Please write a city name in the blank space")
        } else {
            
            let cityName = cityNameTextField.text! //Its alrady validated
            
            addWeatherVM.addWeather(for: cityName) { weatherVM in
                
                //Es llamada la pantalla anterior, llama la funcion y le pasa el ViewModel:
                self.delegate?.addWeatherDidSave(viewModel: weatherVM)
                
                Utils.showAlertMessage("Added", message: "Succesfully added the new city weather", titleAction: "Go to list") { _ in
                    self.dismiss(animated: true)
                }
                
                self.cityNameTextField.text = ""
                self.cityNameTextField.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func closeButtonPressed() {
        self.dismiss(animated: true)
    }
}


// MARK: Textfield

extension AddCityViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        addCityButtonPressed()
        return true
    }
}
