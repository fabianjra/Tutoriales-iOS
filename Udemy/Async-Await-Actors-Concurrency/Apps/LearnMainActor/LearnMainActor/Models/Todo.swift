//
//  Todo.swift
//  Todo
//
//  Created by Mohammad Azam on 7/24/21.
//

import Foundation

struct Todo: Decodable {
    let id: Int 
    let title: String
    let completed: Bool
}
