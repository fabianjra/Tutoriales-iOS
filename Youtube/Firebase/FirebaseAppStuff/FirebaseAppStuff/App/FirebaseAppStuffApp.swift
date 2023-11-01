//
//  FirebaseAppStuffApp.swift
//  FirebaseAppStuff
//
//  Created by Fabian Rodriguez on 31/10/23.
//

import SwiftUI

@main
struct FirebaseAppStuffApp: App {
    
    //Este objeto sera transformado en un EnviromentObject para poder ser utilizando dentro del App. 
    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel )
        }
    }
}
