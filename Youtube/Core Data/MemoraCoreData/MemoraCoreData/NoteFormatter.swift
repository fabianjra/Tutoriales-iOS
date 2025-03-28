
// Encargado de darle el formato a las notas al tipo de estructura que se requiere.

import SwiftUI

class NoteFormatter {
    
    static func notes(from items: FetchedResults<Note>) -> [NoteModel] {
        
        // Forma antigua, sin la relacion de TAG:
        /*
        let noteModels = items.map { item in
            NoteModel(id: item.id!,
                      content: item.content!,
                      date: item.date!,
                      timestamp: item.timestamp!)
        }
         */
        
        let noteModels = items.map({ item in
            
            print("Tag de la nota:")
            print(item.tag?.name ?? "N/A")
            
            let tagModel = item.tag != nil ? TagModel(item.tag!) : nil
            
            return NoteModel(id: item.id!,
                             content: item.content!,
                             date: item.date!,
                             timestamp: item.timestamp!,
                             tag: tagModel)
        })
        
        return noteModels
    }
    
    static func notes(from items: NSSet) -> [NoteModel] {
        let noteModels = items.map ({ item in
            
            if let note = item as? Note {
                
                var tagModel: TagModel? = nil
                
                if let tag = note.tag {
                    tagModel = TagModel(tag)
                }
                
                return NoteModel(id: note.id!,
                                 content: note.content ?? "",
                                 date: note.date!,
                                 timestamp: note.timestamp!,
                                 tag: tagModel)
                
            } else {
                print("Error al convertir NSSet a [NoteModel]")
                return NoteModel(id: UUID(), content: "", date: .now, timestamp: .now, tag: nil)
            }
        })
        
        return noteModels
    }
}
