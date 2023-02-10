//
//  OrderTableViewController.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 8/2/23.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrders()
    }
    
    private func populateOrders(){
        
        let urlGetOrders = "https://warp-wiry-rugby.glitch.me/orders"
        
        guard let coffeOrdersURL = URL(string: urlGetOrders) else {
            fatalError("URL was incorrect")
        }
        
        //We are expecting an Array or orders.
        let resource = Resource<[Order]>(url: coffeOrdersURL)
        
        WebService().load(resource: resource) { result in
            
            switch result {
                
            case .success(let orders):
                print(orders)
                debugPrint(orders)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
