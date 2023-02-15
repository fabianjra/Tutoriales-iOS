//
//  OrderTableViewController.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 8/2/23.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var orderListViewModel = OrderListViewModel() //This View goes to the "ViewModel" to get the data from Services.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrders()
    }
    
    private func populateOrders(){
        
        WebService().load(resource: Order.getAll) { [weak self] result in
            
            switch result {
                
            case .success(let orders):
                //Cuando se obtenga el resultado y se mapea al model "Order", se puede llenar el objeto de "OrderListViewModel"
                self?.orderListViewModel.orders = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
                
            case .failure(let error):
                Utils.showAlertMessage("Error", message: "Error getting the orders: \(error)")
            }
        }
    }//END: populateOrders
}

// - MARK: TableView

extension OrderTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.orders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let orderVM = self.orderListViewModel.order(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableViewCell", for: indexPath)
        
        //Not deprecated options:
        var content = cell.defaultContentConfiguration()
        
        //Configure content:
        content.text = orderVM.type //Similar to: textLabel
        content.secondaryText = orderVM.size //Similar to: detailTextLabel
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// - MARK: Delegate

extension OrderTableViewController: AddOrderDelegate {
    
    //Add this function to use the "Delegate" from the "AddOrderViewController".
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //navC: It's the navigation controller.
        //Because the you press the "add" button, it goes by the navigation controller, to the Modal view "AddOrderViewController".
        //So, first goes to the NavigationController, then to the View.
        guard let navC = segue.destination as? UINavigationController,
              let addOrderVC = navC.viewControllers.first as? AddOrderViewController else {
            Utils.showAlertMessage("Error", message: "There is not Add Order view")
            return
        }
        
        addOrderVC.delegate = self
    }
    
    //Just for closing the modal view.
    func addOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
    
    //Action when press Save button on the AddOrderViewController.
    func addOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        
        //optional: You can clean the Add Order screen or close the modal.
        controller.dismiss(animated: true)
        
        //optional: You can just populate again the TableView, because this fuction will reaload the TableView, by taking the data again in the WebService.
        //populateOrders()
        
        //optional: Adding the new item directly to the TableView:
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.orders.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.orders.count - 1, section: 0)], with: .automatic)
    }
}
