//
//  FirebaseTutorialApp.swift
//  FirebaseTutorial
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import SwiftUI
import Firebase

@main
struct FirebaseTutorialApp: App {
    
    //Se agrega la dependencia de Firebase aqui, ya que este archivo realiza la misma funcion que en el AppDelegate.
    init() {
        //FirebaseConfiguration.shared.setLoggerLevel(.min) //Evitar mensajes de firebase innecesarios.
        //FirebaseConfiguration.shared.setLoggerLevel(.error)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
