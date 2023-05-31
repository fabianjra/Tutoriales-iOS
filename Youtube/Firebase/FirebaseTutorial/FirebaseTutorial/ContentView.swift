//
//  ContentView.swift
//  FirebaseTutorial
//
//  Created by Fabian Rodriguez on 30/5/23.
//

import SwiftUI

//Link Youtube: https://www.youtube.com/watch?v=6b2WAePdiqA

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
