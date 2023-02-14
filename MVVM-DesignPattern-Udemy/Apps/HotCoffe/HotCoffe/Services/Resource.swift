//
//  Resource.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 14/2/23.
//

import Foundation

//Codable: becasuse we need both "Encodable & Decodable", for GET and POST (serialize and deserialize json data).
struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get //Use GET by default.
    
    //Add a body for encoding and send to the WebService.
    var body: Data? = nil //nil by default.
    
    init(url: URL) {
        self.url = url
    }
}
