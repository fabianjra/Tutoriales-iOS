//
//  ListView.swift
//  FirebaseTutorial
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    @State private var showPopup = false
    
    var body: some View {
        NavigationView {
            
            List(dataManager.dogs, id: \.id) { dog in
                Text(dog.breed)
            }
//            .onChange(of: dataManager) { _ in
//                dataManager.fetchDogs()
//            }
            .navigationTitle("Dogs")
            .navigationBarItems(trailing: Button(action: {
                showPopup.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showPopup) {
                NewDogView()
                    .presentationDetents([.medium])
            }
            .onAppear() {
                self.dataManager.fetchDogsPersistance()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(DataManager())
    }
}
