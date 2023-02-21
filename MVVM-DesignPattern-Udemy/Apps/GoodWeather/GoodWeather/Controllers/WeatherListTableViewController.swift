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
         
    }//End: SetupView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addCitySegue" {
            prepareSegueForAddCityViewController(segue: segue)
        }
    }
    
    private func prepareSegueForAddCityViewController(segue: UIStoryboardSegue) {
        
        //El segue va primero al NavigationController, por eso primero se valida el destino para que sea el Nav.
        guard let navC = segue.destination as? UINavigationController else {
            Utils.showAlertMessage("Error", message: "Error al intentar hacer segue al Navigation Controller")
            return
        }
        
        guard let addCityVC = navC.viewControllers.first as? AddCityViewController else {
            Utils.showAlertMessage("Error", message: "Error al intentar hacer segue a la vista de Add City")
            return
        }
        
        
        addCityVC.delegate = self
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

// -- MARK: Delegate from Add Weather

extension WeatherListTableViewController: addWeatherDelegate {
    
    func addWeatherDidSave(viewModel: WeatherViewModel) {
        //TODO: Add the city to the TableView.
        //Utils.showAlertMessage("Added", message: "Added. This is Weather List VC")
    }
}
