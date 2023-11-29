//
//  SwiftDataTutorialApp.swift
//  SwiftDataTutorial
//
//  Created by Fabian Rodriguez on 29/11/23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        //Le indica a la vista que va a trabajar con CountryModel.
        //Puede ser un array seprado por comas. EJEM: [CountryModel.self, UserModel.self, etc...]
        .modelContainer(for: CountryModel.self)
    }
}
