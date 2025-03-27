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
    
    // MARK: NOTES:
    
    func saveNewNote(noteModel: NoteModel) async {
        
        // Se crea un nuevo objeto "Managed Note" para mapear los campos que se van a guardar en la Entidad de Note.
        // Se debe utilizar el contexto que ya está instanciado.
        let noteEntity = Note(context: viewContext)
        
        noteEntity.id = noteModel.id
        noteEntity.content = noteModel.content
        noteEntity.date = noteModel.date
        noteEntity.timestamp = noteModel.timestamp
        
        // Se agrega el tag, validando que exista:
        // Primero valida que exista el tag que se esta pasando por parametro (el seleccionado para ir a guardar la nota con ese Tag),
        // Luego valida que el Tag exista en Core data para guardarlo en la entidad de Note.
        if let tagModel = noteModel.tag, let existingTag = await fetchTag(byName: tagModel.name) {
            
            existingTag.addToNotes(noteEntity) // Esta funcion es propia de Core Data y lo que hace es crear la relacion del Tag con la Nota y asi amarrarla. Es una buena practica que permite relacionarlos correctamente uno con otro.
            noteEntity.tag = existingTag // Esta va a ser la relacion funcional y la que hace que la entidad Note tenga relacioando un Tag especifico.
            
        } else if let tagModel = noteModel.tag {
            // Si no se da el caso de que sea valido el tag seleccionado, entonces se valida que no sea un Tag Nil (o sea, que si venga un objeto tag por parametro)
            // Se crea el Tag en caso de que no exista en Core Data:
            let tagEntity = Tag(context: viewContext)
            tagEntity.name = tagModel.name
            tagEntity.addToNotes(noteEntity) //Al crearse el nuevo Tag, igualmente como en la primera validacion, debe relacionarse el Tag a la nota para amarrar la relacion entre ambos.
            
            noteEntity.tag = tagEntity
        }
        
        do {
            try viewContext.save() //Guarda todos los cambios
            
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
        fetchRequest.fetchLimit = 1 //Solamente obtiene 1 resultado.
        
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
    
    // MARK: TAGS:
    
    func fetchTag(byName name: String) async -> Tag? {
        do {
            let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            fetchRequest.fetchLimit = 1
            
            if let fetchedTag = try viewContext.fetch(fetchRequest).first {
                return fetchedTag
            } else {
                return nil
            }
        } catch {
            print("Error obteniendo el tag: \(error)")
            return nil
        }
    }
}
