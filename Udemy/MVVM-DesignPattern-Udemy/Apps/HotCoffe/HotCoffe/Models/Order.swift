//
//  Order.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

import Foundation

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
    
    static let urlString = "https://warp-wiry-rugby.glitch.me/orders"
    
    static var getAll: Resource<[Order]> = {
        guard let url = URL(string: urlString) else {
            fatalError("URL was incorrect")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    //Resource to pass to the Networking operation:
    //this "Resource" return is the one, we are going to provide to the WebService.
    static func create(viewModel: AddOrderViewModel) -> Resource<Order?> {
        
        let order = Order(viewModel)

        guard let url = URL(string: urlString) else {
            fatalError("URL was incorrect")
        }
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(order)
            
            //We need to set the "resource" to POST for the WebService.
            var resource = Resource<Order?>(url: url)
            resource.httpMethod = .post
            resource.body = data
            
            return resource
        }catch {
            Log.WriteCatchExeption(error: error)
            fatalError("Error encoding order")
        }
    }
}
