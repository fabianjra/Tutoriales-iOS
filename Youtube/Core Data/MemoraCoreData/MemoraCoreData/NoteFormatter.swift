
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
}
