//
//  AddOrderViewController.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 8/2/23.
//

import UIKit

protocol AddOrderDelegate {
    func addOrderViewControllerDidSave(order: Order, controller: UIViewController) //Will be fired when press save button.
    func addOrderViewControllerDidClose(controller: UIViewController) //Will be fired when press close button.
}

class AddOrderViewController: UIViewController {
    
    //Create IBOulets UI Controls
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private var coffeSizeSegmentedControl: UISegmentedControl!
    
    //This is for controling all the things are going to present in the UI.
    private var addOrderViewModel = AddOrderViewModel()
    
    //Create Delegate.
    var delegate: AddOrderDelegate?
    
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
        //It has intrinsic content size, so it's not neccesary to set the Height.
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

// - MARK: Button

extension AddOrderViewController {
    
    @IBAction func close(){
        
        if let delegate = self.delegate {
            delegate.addOrderViewControllerDidClose(controller: self)
        }
    }
    
    @IBAction func save(){

        if nameTextField.text?.isEmptyOrWhitespace() == true {
            Utils.showAlertMessage("Empty name", message:"You have to fill the name space")
            return
        }
        
        if emailTextField.text?.isEmptyOrWhitespace() == true {
            Utils.showAlertMessage("Empty email", message:"You have to fill the email space")
            return
        }

        guard let tableIndexPath = self.tableView.indexPathForSelectedRow else {
            Utils.showAlertMessage("Empty coffe type", message:"You have to select a coffe type")
            return
        }
        
        let selectedSize = self.coffeSizeSegmentedControl.titleForSegment(at: self.coffeSizeSegmentedControl.selectedSegmentIndex)
        
        self.addOrderViewModel.name = nameTextField.text
        self.addOrderViewModel.email = emailTextField.text
        self.addOrderViewModel.selectedSize = selectedSize
        self.addOrderViewModel.selectedType = self.addOrderViewModel.types[tableIndexPath.row]
        
        //Send the ViewModel to the WebService.
        WebService().load(resource: Order.create(viewModel: self.addOrderViewModel)) { result in
            
            switch result {
                
                //In case its success: order was added to the WebService.
            case .success(let order):
                
                //Check if order has value, beacause it's optional.
                if let order = order, let delegate = self.delegate {
                    
                    Utils.showAlertMessage("Added", message:"The order was added succesfully") { _ in
                        //Switch to the Main Thread, because we are going to pass the "order" to the view.
                        DispatchQueue.main.async {
                            delegate.addOrderViewControllerDidSave(order: order, controller: self)
                        }
                    }
                }
                
            case .failure(let error):
                Log.WriteCatchExeption("Error al enviar order al WebService", error: error)
            }
        }
    }
}
