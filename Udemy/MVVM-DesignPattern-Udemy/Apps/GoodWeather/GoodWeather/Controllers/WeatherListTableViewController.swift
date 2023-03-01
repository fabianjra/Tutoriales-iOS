//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 15/2/23.
//

import UIKit

class WeatherListTableViewController: UITableViewController {
    
    //Variables:
    private var weatherListViewModel = WeatherListViewModel() //This can add elements to the VM and get the count of items.
    private var lastUnitSelection: Unit! //Unwrap because it will always have a value
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: Constants.unit) as? String {
            self.lastUnitSelection = Unit(rawValue: value)!
        }
    }
    
    private func setupView(){
        //Se llama individualmente por pantalla, porque en algunas que son por ejemplo de Modal, no se requiere un Titulo en grande.
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addCitySegue" {
            prepareSegueForAddCityViewController(segue: segue)
        }
        
        if segue.identifier == "settingsSegue" {
            prepareSegueForSettingsViewController(segue: segue)
        }
    }
    
    private func prepareSegueForAddCityViewController(segue: UIStoryboardSegue) {
        
        //El segue va primero al NavigationController, por eso primero se valida el destino para que sea el Nav.
        guard let navC = segue.destination as? UINavigationController else {
            Utils.showAlertMessage("Error", message: "Error al intentar hacer segue al Navigation Controller")
            return
        }
        
        if let addCityVC = navC.viewControllers.first as? AddCityViewController {
            
            //Le indica al Delegate de la segunda pantalla, que esta (aqui) va a ser la encargada de manejar esa variable delegate.
            //En la segunda pantalla, Delegate, se convierte en esta pantalla.
            addCityVC.delegate = self
            
        } else {
            Utils.showAlertMessage("Error", message: "Error al intentar hacer segue de Add City. No encontrado")
        }
    }
    
    private func prepareSegueForSettingsViewController(segue: UIStoryboardSegue) {
        
        //El segue va primero al NavigationController, por eso primero se valida el destino para que sea el Nav.
        guard let navC = segue.destination as? UINavigationController else {
            Utils.showAlertMessage("Error", message: "Error al intentar hacer segue al Navigation Controller")
            return
        }
        
        if let settingsVC = navC.viewControllers.first as? SettingsTableViewController {
            
            //Le indica al Delegate de la pantalla de Settings, que este ViewControllre (aqui) va a ser la encargada de manejar esa variable perteneciente a la otra pantalla.
            //En la segunda pantalla (pantalla de settings), ese Delegate, se convierte en esta pantalla.
            settingsVC.delegate = self
            
        } else {
            Utils.showAlertMessage("Error", message: "Error al intentar hacer segue de Settings. No encontrado")
        }
    }
}

// -- MARK: TableView

extension WeatherListTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(WeatherCell.self)", for: indexPath) as? WeatherCell else {
            Utils.showAlertMessage("Error", message: "Error in trying to get the WeatherCell")
            return UITableViewCell()
        }
        
        let weatherItem = weatherListViewModel.modelAt(indexPath.row)
        cell.configure(weatherItem)
        
        return cell
    }
}

// -- MARK: Delegate from Add Weather

extension WeatherListTableViewController: addWeatherDelegate {
    
    func addWeatherDidSave(viewModel: WeatherViewModel) {
        //Utils.showAlertMessage("Added", message: "Added. This is Weather List VC")
        weatherListViewModel.addWeatherViewModel(viewModel)
        self.tableView.reloadData()
    }
}

// -- MARK: Delegate for Settings

extension WeatherListTableViewController: SettingsDelegate {

    func settingsDone(viewModel: SettingsViewModel) {
            
        if lastUnitSelection.rawValue != viewModel.selectedUnit.rawValue {
            weatherListViewModel.updateUnit(to: viewModel.selectedUnit)
            tableView.reloadData()
            lastUnitSelection = Unit(rawValue: viewModel.selectedUnit.rawValue)!
        }
    }
}
