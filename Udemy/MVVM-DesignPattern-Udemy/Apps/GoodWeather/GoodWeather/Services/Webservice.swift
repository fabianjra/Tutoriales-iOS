//
//  Webservice.swift
//  GoodWeather
//
//  Created by Fabian Josue Rodriguez Alvarez on 18/2/23.
//

import Foundation

final class Webservice {
    
    //The completion handler is the one that will excecute when "Fetch" the data.
    //The completion handler will receive a Generic type (model) as a request.
    //The completion handler will return data (inside completion).
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            if let data = data {
                //The completion must have to be call from the "Main Thread" becuase the TableView requires it.
                DispatchQueue.main.async {
                    completion(resource.parse(data)) //the completion handler will return a data
                }
            } else {
                completion(nil)
            }
            
        }.resume() //Will excecute the URLSession.
    }
    
}
