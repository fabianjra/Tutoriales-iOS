//
//  AddOrderViewController.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 8/2/23.
//

import UIKit

class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private var coffeSizeSegmentedControl: UISegmentedControl!
    
    //This is for controling all the things are going to present in the UI.
    private var addOrderViewModel = AddOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        
        self.coffeSizeSegmentedControl = UISegmentedControl(items: addOrderViewModel.sizes)
        self.coffeSizeSegmentedControl.selectedSegmentIndex = 0
        
        self.coffeSizeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(coffeSizeSegmentedControl)
        
        self.coffeSizeSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10).isActive = true
        self.coffeSizeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //It has intrinsic content size
        //self.coffeSizeSegmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

// - MARK: TableView

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addOrderViewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Add de selection icon to the right of cell.
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    //Allows to deselect the previus row.
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeTypeTableViewCell", for: indexPath)
        
        //Not deprecated options:
        var content = cell.defaultContentConfiguration()
        
        //Configure content:
        content.text = self.addOrderViewModel.types[indexPath.row] //Similar to: textLabel
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// - MARK: TextField

extension AddOrderViewController: UITextFieldDelegate {
    
}

// - MARK: Button

extension AddOrderViewController {
     
    @IBAction func save(){
        
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let selectedType = self.coffeSizeSegmentedControl.titleForSegment(at: self.coffeSizeSegmentedControl.selectedSegmentIndex)
        
        guard let tableIndexPath = self.tableView.indexPathForSelectedRow else {
            Log.WriteMessage("Error selecting the row in TableView")
            return
        }
        
        self.addOrderViewModel.name = name
        self.addOrderViewModel.email = email
        self.addOrderViewModel.selectedType = selectedType
        self.addOrderViewModel.selectedSize = self.addOrderViewModel.types[tableIndexPath.row]
        
        //TODO: Convert the Object "addOrderViewModel" to model, so it can serialize to send to the WebService.
    }
}
