//
//  AddOrderViewController.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 8/2/23.
//

import UIKit

class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var coffeSizeSegmentedControl: UISegmentedControl!
    
    //This is for controling all the things are going to present in the UI.
    private let addOrderViewModel = AddOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
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
