//
//  ContentView.swift
//  MemoraCoreData
//
//  Created by Fabian Rodriguez on 12/3/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var showEditScreen = false
    
    @State var selectedNote: NoteModel? = nil
    
    @State var noteModels: [NoteModel] = []
    
    // Permite obtener datos de Core Data:
    // El ordenamiento puede hacerse con varios SortDescritor, por eso se utiliza un array.
    @FetchRequest(sortDescriptors: [
        
        // Ordenamiento para los datos:
        // 1: Primero se declara el tipo de campo por el que se va a ordenar.
        // 2: Luego se indica si debe ser ascendente o no.
        // 3: En un parametro por separado, se pueden agregar animaciones.
        NSSortDescriptor(keyPath: \Note.timestamp, ascending: false)
    ],
                  animation: .default)
    private var notes: FetchedResults<Note>
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Memoria App")
                .font(.system(size: 22, weight: .bold))
                .padding()
            
            Spacer()
            
            Image(systemName: "plus.square.on.square")
                .imageScale(.large)
                .padding()
                .onTapGesture {
                    selectedNote = nil
                    showEditScreen = true
                }
        }
        
        List {
            ForEach(noteModels, id: \.id.uuidString) { item in
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 10) {
                        VStack {
                            
                            Text("\(dayOfMonth(from: item.date))")
                                .font(.title3)
                                .foregroundStyle(.red)
                            
                            Text("\(formatMonthFromDate(item.date))")
                                .font(.body)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Text(item.content)
                            .font(.body)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Tag")
                            .font(.system(size: 12))
                            .foregroundStyle(.black)
                            .padding(5)
                            .background(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Spacer()
                        
                        Image(systemName: "square.and.pencil")
                            .imageScale(.large)
                            .onTapGesture {
                                selectedNote = item
                                // No se va a activar el Sheet directamente aqui, sino hasta que la nota seleccionada tenga un valor.
                            }
                    }
                }
                .padding(10)
                .background(.teal.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .listStyle(PlainListStyle())
        .onChange(of: selectedNote?.content) { _, newValue in
            
            // Con esta validacion se asegura que se va a mostrar el modal cuando se haya seleccionado una nota.
            if newValue != nil {
                showEditScreen = true
            }
        }
        .sheet(isPresented: $showEditScreen) {
            EditNoteView(selectedNote: selectedNote)
                .onDisappear() {
                    //TODO: Perform action
                }
        }
        .onAppear {
            // Se mapean las notas de CoreData a la variable local:
            formatNotes()
            
            print("Tengo \(notes.count) notas guardadas en CoreData")
        }
    }
    
    private func formatNotes() {
        
        guard notes.count > 0 else { return }
        
        noteModels = NoteFormatter.notes(from: notes)
    }
    
    private func dayOfMonth(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    private func formatMonthFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
