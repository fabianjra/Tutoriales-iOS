//
//  Webservice.swift
//  Webservice
//
//  Created by Mohammad Azam on 7/24/21.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case badRequest
}

class Webservice {
    
    
    func getAllTodosAsync(url: URL) async throws -> [Todo] {
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let todos = try? JSONDecoder().decode([Todo].self, from: data)
        return todos ?? [] 
        
    }
    
    func getAllTodos(url: URL, completion: @escaping (Result<[Todo], NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                
                    completion(.failure(.badRequest))
                
                return
            }
            
            guard let todos = try? JSONDecoder().decode([Todo].self, from: data) else {
                
                completion(.failure(.decodingError))
                
                return
            }
            
            
                completion(.success(todos))
            
            
            
        }.resume()
        
    }
    
}
