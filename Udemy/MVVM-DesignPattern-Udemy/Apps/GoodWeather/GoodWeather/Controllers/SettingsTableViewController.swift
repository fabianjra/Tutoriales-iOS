//
//  SettingsTableViewController.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 20/2/23.
//

import UIKit

protocol SettingsDelegate {
    func settingsDone(viewModel: SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Se llama individualmente por pantalla, porque en algunas que son por ejemplo de Modal, no se requiere un Titulo en grande.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // -- MARK: Buttons:
    
    @IBAction func doneButtonPressed() {
        
        //Unwrap the Delegate
        if let delegate = self.delegate {
            delegate.settingsDone(viewModel: settingsViewModel)
        }
        
        self.dismiss(animated: true)
    }
}


// -- MARK: TableView:

extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    //Add de selection icon to the right of cell: Indicating that is selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //1: Basic way to select a row:
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        //2: Another way to unselect all cells:
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        //3: Another way to select and save the united selected.
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
            let unit = Unit.allCases[indexPath.row]
            
            settingsViewModel.selectedUnit = unit
        }
    }
    
    //Allows to deselect the previus row.
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.accessoryType = .none //A way to deselect a row.
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
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
        
        //Validate if a unit is selected when the cell is loaded.
        if settingsItem == settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
}
