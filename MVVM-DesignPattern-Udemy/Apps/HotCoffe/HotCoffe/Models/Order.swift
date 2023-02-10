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
}
