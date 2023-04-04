//
//  WebService.swift
//  RandomQuoteAndImages
//
//  Created by Fabian Josue Rodriguez Alvarez on 4/4/23.
//

import Foundation

enum NetworError: Error {
    case badUrl
    case invalidImageId(Int)
    case decodingError
}

class WebService {
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        
        var randomImages: [RandomImage] = []
        
        for id in ids {
            let randomImage = try await getRandomImage(id: id)
            randomImages.append(randomImage)
        }
        
        return randomImages
    }
    
    private func getRandomImage(id: Int) async throws -> RandomImage {
        
        guard let url = Constants.Urls.getRandomImageUrl() else {
            throw NetworError.badUrl
        }
        
        guard let randomQuoteUrl = Constants.Urls.randomQuoteUrl else {
            throw NetworError.badUrl
        }
        
        //Async let: permite que los 2 llamados puedan correr de manera concurrente (concurrent).
        //Asi no esperar a que un llamado termine para que el siguiente pueda ejecutarse.
        async let (imageData, _) = URLSession.shared.data(from: url)
        async let (randomQuoteData, _) = URLSession.shared.data(from: randomQuoteUrl)
        
        //Aqui se debe utilizar el await, porque la variable "randomQuoteData" es async:
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await randomQuoteData) else {
            throw NetworError.decodingError
        }
        
        //El return de la imagen debe ser await, para esperar la respuesta, asi como se hace con quote arriba en la linea 46.
        return RandomImage(image: try await imageData, quote: quote)
    }
}
