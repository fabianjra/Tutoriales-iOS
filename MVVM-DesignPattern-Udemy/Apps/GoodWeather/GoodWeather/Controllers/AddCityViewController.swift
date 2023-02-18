//
//  AddCityViewController.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 16/2/23.
//

import UIKit

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBAction func addCityButtonPressed() {
        
    }
    
    @IBAction func closeButtonPressed() {
        self.dismiss(animated: true)
    }
}
