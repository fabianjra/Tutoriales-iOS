//
//  Constants.swift
//  RandomQuoteAndImages
//
//  Created by Fabian Josue Rodriguez Alvarez on 4/4/23.
//

import Foundation

struct Constants {
    
    struct Urls {
        
        static func getRandomImageUrl() -> URL? {
            return URL(string: "http://picsum.photos/200/300?uuid=\(UUID().uuidString)")
        }
        
        static let randomQuoteUrl: URL? = URL(string: "http://api.quotable.io/random")
    }
}
