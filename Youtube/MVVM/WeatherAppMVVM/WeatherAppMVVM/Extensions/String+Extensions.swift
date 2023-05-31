//
//  String+Extensions.swift
//  WeatherAppMVVM
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation

extension String {
    
    func isEmptyOrWhiteSpace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}

