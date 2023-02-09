//
//  Utils.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

enum Log {
    
    /**
     Shows an Catch error message on console, and an optional string message.
     
     **Notes:**
     - This function takes the file name where the error is presented, the function name who call it and the line number where the error is presented.
     - By default **file**, **function** and **line** are setted internally, so you can ignore these parameters.
     
     **Example:**
     ```swift
     do{
        let article = try JSONDecoder().decode(T.self, from: data)
     
         if let article = article {
            completion(article)
         }
     }catch{
        Log.WriteCatchExeption(err: error)
     }
     ```
    
     - Parameters:
        - message:Optional string message to add to the print.
        - error: The catch error message from the try.
     
     - Returns: Void
     
     - Warning: N/A
     
     - Throws: N/A
     
     - Authors: Fabian Rodriguez
     
     - Version: 1.0
     
     - Date: February 2023
     */
    static func WriteCatchExeption(_ message: String? = nil, file: String = #file, function: String = #function, line: Int = #line, error: Error) {
        print("Error in catch - \(message ?? ""), called by: \(file.components(separatedBy: "/").last ?? file) - \(function), at line: \(line). Description: ", error)
    }
    
    /**
     Shows a message on console.
     
     **Notes:**
     - Writes a simple string message on console.
     
     **Example:**
     ```swift
     Log.WriteMessage("This is a string message.")
     ```
    
     - Parameters:
        - message:String message to add to the print.
     
     - Authors: Fabian Rodriguez
     
     - Version: 1.0
     
     - Date: February 2023
     */
    static func WriteMessage(_ message: String) {
        print(message)
    }
}
