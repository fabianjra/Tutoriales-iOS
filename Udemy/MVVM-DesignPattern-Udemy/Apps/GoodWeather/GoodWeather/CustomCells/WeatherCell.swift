//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 16/2/23.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ weatherVM: WeatherViewModel) {
        
        self.cityNameLabel.text = weatherVM.city
        self.temperatureLabel.text = weatherVM.temperature.formatAsDegree
    }
}
