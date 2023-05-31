//
//  NewDogView.swift
//  FirebaseTutorial
//
//  Created by Fabian Rodriguez on 31/5/23.
//

import SwiftUI

struct NewDogView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    @State private var newDog = ""
    
    var body: some View {
        
        ZStack {
            
            Color.blue
                .ignoresSafeArea()
         
            VStack {
                TextField("Dog breed", text: $newDog)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                    .padding()
                
                Button {
                    dataManager.addDog(newDog)
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
}

struct NewDogView_Previews: PreviewProvider {
    static var previews: some View {
        NewDogView()
    }
}
