//
//  ContentView.swift
//  CoreDataTutorialSwiftUI
//
//  Created by Fabian Rodriguez on 22/2/25.
//

import SwiftUI

enum Priority: String, Identifiable, CaseIterable {
    var id: UUID {
        return UUID()
    }
    
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

extension Priority {
    var title: String {
        return self.rawValue
    }
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // Obtiene los datos de Core Data, ordenados por la llave "dateCreated"
    @FetchRequest(entity: TaskModel.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)])
    private var allTasks: FetchedResults<TaskModel>
    
    @State private var title = ""
    @State private var selectedPriority: Priority = .medium
    
    private func saveTask() {
        
        do {
            let task = TaskModel(context: viewContext)
            task.title = title
            task.priority = selectedPriority.rawValue
            task.dateCreated = .now
            
            try viewContext.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateTask(_ task: TaskModel) {
        task.isFavorite.toggle()
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteTask(at offset: IndexSet) {
        
        offset.forEach { index in
            let task = allTasks[index]
            viewContext.delete(task) //Aqui no se elimina realmente, solamente se marca para la eliminacion.
        }
        
        do {
            try viewContext.save() //Persite los cambios en la base de datos.
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func styleForPriority(_ value: String) -> Color {
        
        let priority = Priority(rawValue: value)
        
        switch priority {
        case .low:
            return Color.green
            
        case .medium:
            return Color.orange
            
        case .high:
            return Color.red
            
        default:
            return Color.black
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter title", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                Picker("Priority", selection: $selectedPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.title).tag(priority)
                    }
                }
                .pickerStyle(.segmented)
                
                Button("Save") {
                    saveTask()
                }
                .buttonStyle(.bordered)
                
                List {
                    ForEach(allTasks) { task in
                        HStack {
                            Circle()
                                .fill(styleForPriority(task.priority ?? "Medium"))
                                .frame(width: 20, height: 20)
                            
                            Text(task.title ?? "null")
                            
                            Spacer()
                            
                            Image(systemName: task.isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(.red)
                                .onTapGesture {
                                    updateTask(task)
                                }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("All tasks")
        }
    }
}

#Preview {
    let persistenceContainer = CoreDataManager.shared.persistentContainer
    
    ContentView()
        .environment(\.managedObjectContext, persistenceContainer.viewContext)
}
