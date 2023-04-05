//
//  ContentView.swift
//  RandomQuoteAndImages
//
//  Created by Fabian Josue Rodriguez Alvarez on 4/4/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var randomImageListVM = RandomImageListViewModel()
    
    var body: some View {
        VStack {
            
            //No hace falta pasarle un ID al List, porque ya el struct conforma "Identifiable" y contiene dentro una variable "id" UUID()
            List(randomImageListVM.randomImages) { randomImage in
                
                HStack {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Text(randomImage.quote)
                }
            }
            .task {
                await randomImageListVM.getRandomIages(ids: Array(100...120))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
