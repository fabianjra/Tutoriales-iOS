//
//  WebService.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

import Foundation

//Error types for the errors using WebService
enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

//Enum to add "POST" methods.
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class WebService {
    
    //It's a generic type, because you don't know if you are getting coffe orders, users, etc.
    func load<T>(resource: Resource<T>, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            //Validate if "data" have value, only in case when error = nil
            guard let data = data, error == nil else {
                Utils.showAlertMessage("Error en obtender data del webservice.")
                completion(.failure(.domainError))
                return //Finish the guard.
            }
            
            let decoder = JSONDecoder()
            
            //It's "T" because is generic type.
            let result = try? decoder.decode(T.self, from: data)
            
            //Unwrap the result.
            if let result = result {
                
                //We are using "main" because eventually we are going to pass this result to the UI.
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
                //If can't unwrap the result, it's because there is an error.
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume() //Execute the "URLSession".
    }
}
