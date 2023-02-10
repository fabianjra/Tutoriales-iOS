//
//  OrderViewModel.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

//NOTE: View Model is going to take all the orders and give it to the View to display the data.

//Struct because we need only to use for the model.
struct OrderViewModel {
    let order: Order
}


// - MARK: GETTERS

extension OrderViewModel {
    
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    //GET: Raw value because we want to get the "case name" in string format.
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    //GET: Raw value because we want to get the "case name" in string format.
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
