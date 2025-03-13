//
//  MemoraCoreDataApp.swift
//  MemoraCoreData
//
//  Created by Fabian Rodriguez on 12/3/25.
//

import SwiftUI

@main
struct MemoraCoreDataApp: App {
    
    // Instancia unica del contenedor
    let persistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
            // Permite que el viewContext este disponible dentro de toda la aplicacion mediante una unica instancia.
            // El ViewContext es lo unico a lo que se necesita acceder dentro de las pantallas de la aplicacion,
            // para hacer uso de los datos con Core Data.
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
