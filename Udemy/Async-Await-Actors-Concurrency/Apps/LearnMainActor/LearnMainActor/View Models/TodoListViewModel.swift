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
    
    func populateTodos() async {
       
        do {
            
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
                throw NetworkError.badUrl
            }
            
            Task.detached { // background thread
                print(Thread.isMainThread)
                let todos = try await Webservice().getAllTodosAsync(url: url)
                await MainActor.run {
                    print(Thread.isMainThread)
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
