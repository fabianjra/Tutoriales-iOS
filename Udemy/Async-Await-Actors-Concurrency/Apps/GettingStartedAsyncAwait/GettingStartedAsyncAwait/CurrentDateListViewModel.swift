//
//  CurrentDateListViewModel.swift
//  GettingStartedAsyncAwait
//
//  Created by Fabian Josue Rodriguez Alvarez on 1/3/23.
//

import Foundation

//Main actor means, that everything iside this calss (properties, functions, etc), Will be call inside the Main Thread
@MainActor
class CurrentDateListViewModel: ObservableObject {
    
    @Published var currentDates: [CurrentDateViewModel] = []
    
    func populateDates() async throws {
        
        do {
            let currentDate = try await Webservice().getDate()
            
            if let currentDate = currentDate {
                
                //Manejar la respuesta en un CurrentDateViewModel:
                //Se debe pasar al @Published.
                let currentDateViewModel = CurrentDateViewModel(currentDate: currentDate)
                
                //Ya no se llama con DispatchQueue.main, porque ya se esta utilizando @MainActor:
                /*
                 //Se debe agregar el ViewModel al Published con DispatchQueue:
                 DispatchQueue.main.async {
                 self.currentDates.append(currentDateViewModel) //Self, because it's inside a closue.
                 }
                 */
                
                currentDates.append(currentDateViewModel)
            }
            
        } catch {
            print("Error de catch: \(error)")
        }
        
    }
}

struct CurrentDateViewModel {
    let currentDate: CurrentDate
    
    var id: UUID {
        currentDate.id
    }
    
    var date: String {
        currentDate.date
    }
}
