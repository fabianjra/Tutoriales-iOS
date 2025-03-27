//

import SwiftUI

enum EditMode {
    case edit
    case add
}

struct EditNoteView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var selectedNote: NoteModel?
    
    var mode: EditMode {
        selectedNote != nil ? .edit : .add
    }
    
    @State var note: String = ""
    @State var date = Date()
    
    // Tags
    @State var selectedTag: String = "Personal"
    @State var personalTag = true
    @State var otherTag = false
    
    let allTags = ["Personal", "Work", "Others", "Hobbies"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("\(mode == .add ? "Add a Note": "Edit this Note")").font(.title2)
            VStack {
                TextEditor(text: $note)
                    .font(.title2)
                    .padding()
            }
            .frame(minWidth: 300, minHeight: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.8), lineWidth: 1)
            ).padding()
            
            
            DatePicker(
                "Note Date",
                selection: $date,
                in: ...Date.now,
                displayedComponents: [.date]
            )
            
            HStack {
                Text("Add a Tag to this note")
                Spacer()
                Picker("Options", selection: $selectedTag) {
                    ForEach(allTags, id: \.self) { t in
                        Text(t).tag(t)
                    }
                }
            }
            
            Button(action: {
                
                guard note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else { return }
                
                Task {
                    if mode == .add {
                        await addNewNote()
                    } else {
                        await updateNote()
                    }
                    
                    dismiss()
                }
                
            }, label: {
                Text("Save Note")
            }).frame(width: 350, height: 50)
                .background(.teal.opacity(0.4))
                .foregroundColor(Color(.label))
                .cornerRadius(200)
                .padding(.top, 30)
            
            Spacer()
            
        }.padding(30)
            .onAppear() {
                // update the view properties to use selected note if in edit mode
                if selectedNote != nil {
                    note = selectedNote?.content ?? ""
                    date = selectedNote?.date ?? .now
                    
                }
            }
    }
    
    func addNewNote() async -> Void {
        
        //Se agrega el tag al NotaModel creado:
        let tagModel = TagModel(name: selectedTag)
        
        let noteModel = NoteModel(id: UUID(),
                                  content: note,
                                  date: date,
                                  timestamp: .now,
                                  tag: tagModel)
        
        await MemoraManager.shared.saveNewNote(noteModel: noteModel)
    }
    
    func updateNote() async -> Void {
        
        // Se verifica la nota sobre la que se esta trabajando (selectedNote):
        guard selectedNote != nil else {
        print("No se ha seleccionado una nota para editar.")
            return
        }
        
        let noteModel = NoteModel(id: selectedNote!.id,
                                  content: note,
                                  date: date,
                                  timestamp: selectedNote!.timestamp)
        
        print("se va a actualizar la nota")
        await MemoraManager.shared.updateNote(noteModel: noteModel)
        print("se ha actualizado la nota")
    }
}
#Preview {
    EditNoteView()
}
