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
        
        let url = AppDelegate.getWeatherURL("ohio")
        
        //We are expecting a "WeatherResponse" type (the root from the Json response).
        let resource = Resource<WeatherResponse>(url: url) { data in
            
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode(WeatherResponse.self, from: data)
                return response
                
            }catch{
                Log.WriteCatchExeption(error: error)
                Utils.showAlertMessage("Error", message: error.localizedDescription)
                return nil
            }
        }//End: Resource instantiation.
    
        //NOTA: Posiblemente en algunos casos pueda provocarse un error de "Transport Seccurity" llamado "finished with error".
        //Para solucionar eso:
        //1: Se agrega el info.plist la llave: "App Transport Security Settigns".
        //2: Dentro de la llave agregada, se agrega una subllave llamada: "Allow Arbitrary Loads".
        //3: Se pone en subllave con el valor "YES".
        Webservice().load(resource: resource) { weatherResponse in
            
            if let weatherResponse = weatherResponse {
                
                Utils.showAlertMessage("Temperature response", message: "Temperature: \(weatherResponse.main.temperature.description)° and humidity: \(weatherResponse.main.humidity.description)")
            }
        }
        
    }//End: SetupView
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
