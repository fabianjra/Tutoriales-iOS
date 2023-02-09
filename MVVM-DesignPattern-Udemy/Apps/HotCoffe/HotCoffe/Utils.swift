//
//  Utils.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

enum Log {
    
    /// Shows an Catch error message on console, and an optional string message.
    /// - Parameters:
    ///    - message: Optional string message to add to the print.
    ///    - err: The catch error message from the try.
    static func WriteCatchExeption(_ message: String? = nil, file: String = #file, function: String = #function, line: Int = #line, err: Error) {
        print("Error in catch - \(message ?? ""), called by: \(file.components(separatedBy: "/").last ?? file) - \(function), at line: \(line). Description: ", err)
    }
    
    /// Shows a string message on console.
    /// - Parameters:
    ///    - message: Menssage to write on console..
    static func WriteMessage(_ message: String) {
        print(message)
    }
}
