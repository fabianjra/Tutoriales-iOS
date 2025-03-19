
// Encargado de darle el formato a las notas al tipo de estructura que se requiere.

import SwiftUI

class NoteFormatter {
    
    static func notes(from items: FetchedResults<Note>) -> [NoteModel] {
        
        let noteModels = items.map { item in
            
            NoteModel(id: item.id!,
                      content: item.content!,
                      date: item.date!,
                      timestamp: item.timestamp!)
        }
        
        return noteModels
    }
}
