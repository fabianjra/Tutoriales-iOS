//
//  Webservice.swift
//  GettingStartedAsyncAwait
//
//  Created by Fabian Josue Rodriguez Alvarez on 1/3/23.
//

import Foundation

class Webservice {
    
    func getDate() async throws -> CurrentDate? {
        let urlString = "https://ember-sparkly-rule.glitch.me/current-date"
        
        guard let url = URL(string: urlString) else {
            fatalError("El URL es incorrecto")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        //If the app crashes: The try will return nil, because it's optional.
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
}
