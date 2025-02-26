//
//  CoreDataTutorialSwiftUIApp.swift
//  CoreDataTutorialSwiftUI
//
//  Created by Fabian Rodriguez on 22/2/25.
//

import SwiftUI

@main
struct CoreDataTutorialSwiftUIApp: App {
    
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView() // Se inyecta el container al root View, para que sea accesible desde cualquier parte de la app.
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
