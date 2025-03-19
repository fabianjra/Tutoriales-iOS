//
//  MemoraManager.swift
//  MemoraCoreData
//
//  Created by Fabian Rodriguez on 16/3/25.
//

// Archivo encargado de todo el funcionamiento de Core Data.
// Puede tener el nombre que se quiera, en este caso, manager para saber que es el encargado de
// la comunicacion de la UI con Core Data.

import CoreData

class MemoraManager {
    
    static let shared = MemoraManager() // Singleton: Va a ser una unica instancia.
    
    // El ViewContext es lo que se va a modificar.
    // Cuando se agregue una nueva nota, se debe obtener el ViewContext para utilizarlo.
    private let viewContext: NSManagedObjectContext
    
    private init() {
        self.viewContext = PersistenceController.shared.container.viewContext
    }
    
    func saveNewNote(noteModel: NoteModel) async {
        
        // Se crea un nuevo objeto "Managed Note" para mapear los campos que se van a guardar en la Entidad de Note.
        // Se debe utilizar el contexto que ya está instanciado.
        let noteEntity = Note(context: viewContext)
        
        noteEntity.id = noteModel.id
        noteEntity.content = noteModel.content
        noteEntity.date = noteModel.date
        noteEntity.timestamp = noteModel.timestamp
        
        do {
            try viewContext.save()
            
            print("Nota guardada con exito. ID: \(String(describing: noteEntity.id))")
        } catch {
            print("Error al guardar la nueva nota: \(error.localizedDescription)")
        }
        
        
    }
}
