//
//  TodoListViewModel.swift
//  TodoListViewModel
//
//  Created by Mohammad Azam on 7/24/21.
//

import Foundation

@MainActor
class TodoListViewModel: ObservableObject {
    
    @Published var todos: [TodoViewModel] = []
    
    //MainActor puede llamarse tambien directamente sobre una funcion solamente.
    //El problema es que aunque se llame directamente MainActor sobre esta funcion, no va a hacer que precisamente la funcion CompletionHanlder Callback se llame sobre el MainThread.
    //@MainActor
    func populateTodos() async {
       
        do {
            
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
                throw NetworkError.badUrl
            }
            
            //Detached significa que no va a ejecutarse sobre el Main Thread, sino en otro.
            Task.detached {
                //Ingreso al background thread
                
                //Print para saber si se encuentra en el Main Thread. Print es False.
                print(Thread.isMainThread)
                
                let todos = try await Webservice().getAllTodosAsync(url: url)
                
                //MainActor.run ejecuta una funcion directamente en el MainThread, aun estando dentro de Task.Detached:
                await MainActor.run {
                    print(Thread.isMainThread) //Print true, porque ahora sí esta dentro del Main Thread.
                    self.todos = todos.map(TodoViewModel.init)
                }
            }
            
           
            
        } catch {
            print(error)
        }
    }
}

struct TodoViewModel {
    
    let todo: Todo
    
    var id: Int {
        todo.id
    }
    
    var title: String {
        todo.title
    }
    
    var completed: Bool {
        todo.completed
    }
}
