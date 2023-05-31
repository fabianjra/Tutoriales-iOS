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
    
    //Eviatr error que no permite cargar Firebase:
    @StateObject var dataManager = DataManager()
    
    //Se agrega la dependencia de Firebase aqui, ya que este archivo realiza la misma funcion que en el AppDelegate.
    init() {
        //FirebaseConfiguration.shared.setLoggerLevel(.min) //Evitar mensajes de firebase innecesarios.
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            
            //TODO: Remove. Testing porpuses:
            ListView()
                .environmentObject(dataManager)
        }
    }
}
