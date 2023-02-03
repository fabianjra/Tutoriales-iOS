//
//  Utils.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 2/2/23.
//

enum Log {
    
    /// Imprime en consola un error de un Catch.
    /// - Parameters:
    ///   - message: Mensaje opcional a parte del errro del catch.
    ///   - err: Error que retorna el Catch del Try.
    static func WriteCatchExeption(_ message: String? = nil, file: String = #file, function: String = #function, line: Int = #line, err: Error) {
        print("Error in catch - \(message ?? ""), called by: \(file.components(separatedBy: "/").last ?? file) - \(function), at line: \(line). Description: ", err)
    }
}
