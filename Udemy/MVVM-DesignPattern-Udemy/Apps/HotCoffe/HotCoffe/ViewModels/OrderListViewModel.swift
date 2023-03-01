//
//  OrderListViewModel.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

class OrderListViewModel {
    
    var orders: [OrderViewModel]
    
    init() {
        self.orders = [OrderViewModel]()
    }
    
    func order(at index: Int) -> OrderViewModel {
        return self.orders[index]
    }
}
