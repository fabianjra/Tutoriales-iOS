//
//  AddOrderViewModel.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 10/2/23.
//

struct AddOrderViewModel {
    
    var name: String?
    var email: String?
    
    var types: [String] {
        return CoffeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeSize.allCases.map { $0.rawValue.capitalized }
    }
}
