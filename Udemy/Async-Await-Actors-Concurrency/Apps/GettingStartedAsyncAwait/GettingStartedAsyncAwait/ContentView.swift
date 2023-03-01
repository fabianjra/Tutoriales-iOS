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
    
    @State private var currentDates: [CurrentDate] = []
    
    private func getDate() async throws -> CurrentDate? {
        let urlString = "https://ember-sparkly-rule.glitch.me/current-date"
        
        guard let url = URL(string: urlString) else {
            fatalError("El URL es incorrecto")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        //If the app crashes: The try will return nil, because it's optional.
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
    
    private func populateDates() async {
        do {
            guard let currentDate = try await getDate() else {
                return
            }
            
            self.currentDates.append(currentDate)
        } catch {
            print("Error: \(error)")
        }
    }
    
    var body: some View {
        NavigationView {
            List(self.currentDates) { currentDate in
                Text("\(currentDate.date)")
            }.listStyle(.plain)
            
                .navigationTitle("Fechas")
            
                .navigationBarItems(trailing: Button(action: {
                    //Button Action
                    
                    Task {
                        await populateDates()
                    }
                    
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                }))
            
            //This function is fired when a particular view (the list) appears on the screen.
            //To perform an Asyncronous request or a Fetch.
                .onAppear { }
            
            //Insted of .onAppear, we can use Task, because this one uses "Async" Closure:
                .task {
                    await populateDates()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
