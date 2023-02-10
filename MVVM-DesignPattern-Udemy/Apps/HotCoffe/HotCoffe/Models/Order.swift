//
//  Order.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

//CaseIterable: Allows to iterate the CoffeType Enum.
enum CoffeType: String, Codable, CaseIterable {
    case cappuccino
    case lattee
    case expressino
    case cortado
}

//CaseIterable: Allows to iterate the CoffeType Enum.
enum CoffeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeType
    let size: CoffeSize
    
    //Optinal init
    init?(_ viewModel: AddOrderViewModel) {
        
        //Valida que los datos obtenidos tengan datos
        guard let name = viewModel.name,
              let email = viewModel.email,
              let selectedType = CoffeType(rawValue: viewModel.selectedType!.lowercased()),
              let selectedSize = CoffeSize(rawValue: viewModel.selectedSize!.lowercased()) else {
            
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }//End: init
}
