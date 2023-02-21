//
//  SettingsTableViewController.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 20/2/23.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Se llama individualmente por pantalla, porque en algunas que son por ejemplo de Modal, no se requiere un Titulo en grande.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // -- MARK: Buttons:
    
    @IBAction func doneButtonPressed() {
        self.dismiss(animated: true)
    }
}


// -- MARK: TableView:

extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingsItem = settingsViewModel.units[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        //Not deprecated options:
        var content = cell.defaultContentConfiguration()
        
        //Configure content:
        content.text = settingsItem.displayName //Similar to: textLabel
        //content.secondaryText = "" //Similar to: detailTextLabel
        
        cell.contentConfiguration = content
        
        return cell
    }
}
