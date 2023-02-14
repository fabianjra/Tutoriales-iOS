//
//  Utils.swift
//  HotCoffe
//
//  Created by Fabian Josue Rodriguez Alvarez on 9/2/23.
//

// MARK: - Logs

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

// MARK: - Functions

import UIKit

struct Utils {
    
    /**
     Shows an alert view
     
     - Parameters:
        - message: Message will show in the Alert.
        - isModal: Set true when it's used in a modal or Popup. This is false by default.
     
     - Authors: Fabian Rodriguez
     
     - Version: 1.0
     
     - Date: February 2023
     */
    static func showAlertMessage(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertAction.Style.cancel, handler: { _ in
            //Close this alert.
            print("Error message from AlertView in Utils: \(message)")
        }))
        
        let actualVC = getActualViewController()
        
        if let actualVC = actualVC {
            actualVC.present(alert, animated: true, completion: nil)
        }
    }
    
    /**
     Get the Interface Orientation device.
     
     **Notes:**
     An application can use more than one scene, each with one or more windows.
     Use the connectedScenes method to obtain the list of connected scenes for the application.
     Use the window or keyWindow property on a scene to obtain the window.
     If you are certain that your app uses only one scene with one window you could obtain the same root view controller using the following:
     
     - Authors: Fabian Rodriguez
     
     - Version: 1.0
     
     - Date: February 2023
     */
    func getUIInterfaceOrientation() -> UIInterfaceOrientation {
        
        //Not deprecated code.
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .unknown
        }
        
        guard let firstWindow = firstScene.windows.first else {
            return .unknown
        }
        
        return firstWindow.windowScene?.interfaceOrientation ?? .unknown
    }
    
    /**
     Get the root view controller or the presented view controller in case it's called by a Modal.
     
     - Authors: Fabian Rodriguez
     
     - Version: 1.0
     
     - Date: February 2023
     */
    private static func getActualViewController() -> UIViewController? {
        
        //Not deprecated code fot the windowScene.
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        
        guard let firstWindow = firstScene.windows.first else {
            return nil
        }
        
        //Each ViewController keeps track of the view it has presented, so we can move from the head to the tail, which will always be the current view
        let rootVC = firstWindow.windowScene?.keyWindow?.rootViewController
        
        //If it's a modal, return the presented view controller.
        if rootVC?.presentedViewController != nil {
            return rootVC?.presentedViewController
        } else {
            return rootVC?.children.last
        }
    }
}
