//
//  Utils.swift
//  WeatherAppMVVM
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import Foundation

enum Log {
    static func WriteCatchExeption(_ message: String? = nil, file: String = #file, function: String = #function, line: Int = #line, error: Error) {
        print("Error in catch - \(message ?? ""), called by: \(file.components(separatedBy: "/").last ?? file) - \(function), at line: \(line). Description: ", error)
    }
}
