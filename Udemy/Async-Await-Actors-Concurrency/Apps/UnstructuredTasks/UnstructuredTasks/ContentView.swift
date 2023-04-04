//
//  ContentView.swift
//  UnstructuredTasks
//
//  Created by Fabian Josue Rodriguez Alvarez on 3/4/23.
//

import SwiftUI

struct ContentView: View {
    
    private func getData() async {
        //get the data
    }
    
    var body: some View {
        VStack {
            
            Button {
                
                //Crea un closure:
                Task{
                    await getData()
                }
                
            } label: {
                Text("Get data")
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .tint(.teal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
