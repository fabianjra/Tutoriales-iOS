//
//  AddCityViewController.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 16/2/23.
//

import UIKit

class AddCityViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    
    // -- MARK: Buttons
    
    @IBAction func addCityButtonPressed() {
        
        if cityNameTextField.text?.isEmptyOrWhitespace() == true {
            Utils.showAlertMessage("Empty space", message: "Please write a city name in the blank space")
        } else {
            
            let city = cityNameTextField.text! //Its alrady validated
            let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=4b04a0477518e155d94c9a37678059bb&units=imperial"
            let url = URL(string: weatherURL)!
            
            let resource = Resource<Any>(url: url) { data in
                return data
            }
            
            Webservice().load(resource: resource) { result in
                
            }
        }
    }
    
    @IBAction func closeButtonPressed() {
        self.dismiss(animated: true)
    }
}
