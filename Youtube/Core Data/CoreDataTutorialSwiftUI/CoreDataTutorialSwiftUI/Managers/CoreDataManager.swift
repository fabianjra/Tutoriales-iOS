//
//  CoreDataManager.swift
//  CoreDataTutorialSwiftUI
//
//  Created by Fabian Rodriguez on 25/2/25.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    // Se crea un shared y un private init para no crear diferentes intancias del container
    private init() {
        persistentContainer = NSPersistentContainer(name: "SimpleTodoModel") // Se usa el nombre del modelo de CoreData (el archivo donde estan las entidades).
        persistentContainer.loadPersistentStores { description, error in
            
            if let error = error {
                fatalError("Unable to load persistent Core Data: \(error)")
            } 
        }
    }
    
}
