//
//  RandomImage.swift
//  RandomQuoteAndImages
//
//  Created by Fabian Josue Rodriguez Alvarez on 4/4/23.
//

import Foundation

struct RandomImage: Decodable {
    let image: Data
    let quote: Quote
}

struct Quote: Decodable {
    let conte: String
}
