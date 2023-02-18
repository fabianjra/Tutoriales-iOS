//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 15/2/23.
//

import UIKit

class WeatherListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// -- MARK: TableView

extension WeatherListTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(WeatherCell.self)", for: indexPath) as? WeatherCell else {
            fatalError("Failed to dequeue cell.")
            //return nil //Podria manejarse con return nil y la respuesta como un opcional.
        }
        
        cell.cityNameLabel.text = "New York"
        cell.temperatureLabel.text = "17 C°"

        return cell
    }
}
