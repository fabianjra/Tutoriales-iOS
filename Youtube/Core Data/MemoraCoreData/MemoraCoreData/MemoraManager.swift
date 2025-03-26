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
    
    func updateNote(noteModel: NoteModel) async {
        
        // Primero se necesita hacer el Fetch Request para saber cual nota se va a modificar.
        let fetchRequest = Note.fetchRequest()
        
        // NSPredicate permite buscar un valore de una entidad filtrando.
        // NSPredicate solamente establece una configuracion de busqueda. Aun no se busca nada aqui.
        // Format: formato de filtro (en este caso, busqueda por ID).
        // argument: Reemplazo del %@ para igualarlo al valor a buscar.
        fetchRequest.predicate = NSPredicate(format: "id == %@", noteModel.id.uuidString)
        fetchRequest.fetchLimit = 1
        
        do {
            //Se realiza la busqueda en base a la configuracion establecida con fetchRequest
            let requestNote = try viewContext.fetch(fetchRequest)
            
            guard let existingNote = requestNote.first else {
                print("No se encontró la nota con el ID proporcionado.")
                return
            }
            
            existingNote.content = noteModel.content
            existingNote.date = noteModel.date
            //existingNote.timestamp = noteModel.timestamp
            
            try viewContext.save()
        } catch {
            print("Error al realizar el Fetch Request o Guardar los datos: \(error)")
        }
    }
    
    func deleteNote(noteId: UUID) async {
        
        do {
            let fetchRequest = Note.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", noteId.uuidString)
            
            if let noteToDelete = try viewContext.fetch(fetchRequest).first {
                
                viewContext.delete(noteToDelete)
                
                try viewContext.save()
                print("Nota eliminada con éxito.")
            }
        } catch {
            print("Error deleting note: \(error)")
        }
    }
}
