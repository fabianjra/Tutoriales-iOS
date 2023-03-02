//
//  ContentView.swift
//  GettingStartedAsyncAwait
//
//  Created by Fabian Josue Rodriguez Alvarez on 28/2/23.
//

import SwiftUI

struct ContentView: View {
    
    //Se utiliza con StateObject, porque la clase es "ObservableObject":
    @StateObject private var currentDateListVM = CurrentDateListViewModel()
    
    var body: some View {
        NavigationView {
            List(currentDateListVM.currentDates, id: \.id) { currentDate in
                Text("\(currentDate.date)")
            }.listStyle(.plain)
            
                .navigationTitle("Fechas")
            
                .navigationBarItems(trailing: Button(action: {
                    //Button Action
                    
                    Task {
                        
                        //No se ocupa "try" porque ya la funcion de populate utiliza un try catch adentro.
                        await currentDateListVM.populateDates()
                    }
                    
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                }))
            
            //This function is fired when a particular view (the list) appears on the screen.
            //To perform an Asyncronous request or a Fetch.
                .onAppear { }
            
            //Insted of .onAppear, we can use Task, because this one uses "Async" Closure:
                .task {
                    
                    //No se ocupa "try" porque ya la funcion de populate utiliza un try catch adentro.
                    await currentDateListVM.populateDates()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
