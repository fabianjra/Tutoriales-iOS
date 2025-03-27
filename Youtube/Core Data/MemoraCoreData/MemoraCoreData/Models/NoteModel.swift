//
//  NoteModel.swift
//  MemoraCoreData
//
//  Created by Fabian Rodriguez on 12/3/25.
//

import Foundation

// Se agrega el sufijo "Model" para diferenciarlo de la entidad llamada "Note"
struct NoteModel {
    var id: UUID = UUID()
    let content: String
    let date: Date // Date that memory occurred
    let timestamp: Date //The entry date.
    let tag: TagModel? 
    
    init(id: UUID, content: String, date: Date, timestamp: Date, tag: TagModel? = nil) {
        self.id = id
        self.content = content
        self.date = date
        self.timestamp = timestamp
        self.tag = tag
    }
    
    // Va a tomar solamente una nota en base a la entidad creada en el Model de CoreData.
    // Inicializa el Modelo con los valores de la Entidad.
    init(note: Note) {
        self.id = note.id!
        self.content = note.content ?? ""
        self.date = note.date!
        self.timestamp = note.timestamp!
        self.tag = note.tag != nil ? TagModel(note.tag!) : nil
    }
}
