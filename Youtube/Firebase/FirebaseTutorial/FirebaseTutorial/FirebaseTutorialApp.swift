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
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
