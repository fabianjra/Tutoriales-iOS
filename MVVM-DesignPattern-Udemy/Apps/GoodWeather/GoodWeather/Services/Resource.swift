//
//  Resource.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 18/2/23.
//

import Foundation

// T: Means that I will request a "T" type. So, a Generic Type.
struct Resource<T> {
    let url: URL
    let parse: (Data) -> T? //Closure
}
