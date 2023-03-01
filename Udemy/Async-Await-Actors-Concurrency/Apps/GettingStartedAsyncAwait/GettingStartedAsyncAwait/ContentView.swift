//
//  ContentView.swift
//  GettingStartedAsyncAwait
//
//  Created by Fabian Josue Rodriguez Alvarez on 28/2/23.
//

import SwiftUI

struct CurrentDate: Decodable, Identifiable {
    let id = UUID()
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(1...10, id: \.self) { index in
                Text("\(index)")
            }.listStyle(.plain)
            
                .navigationTitle("Fechas")
            
                .navigationBarItems(trailing: Button(action: {
                    //Button Action
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
