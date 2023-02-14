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
                print(error)
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
