//
//  Order.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

enum CoffeType: String, Codable {
    case cappuccino
    case lattee
    case expressino
    case cortado
}

enum CoffeSize: String, Codable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeType
    let size: CoffeSize
}
