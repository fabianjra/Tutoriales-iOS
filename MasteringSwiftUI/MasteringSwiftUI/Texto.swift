//
//  ContentView.swift
//  MasteringSwiftUI
//
//  Created by Fabian Josue Rodriguez Alvarez on 23/9/22.
//

import SwiftUI

struct Texto: View {
    var body: some View {
        VStack {
            
            //Custom font
            Text("Custom font Nunito")
                .font(.custom("Nunito", size: 25))
            
            //Markdown Text
            Text("**Texto con markdown** *this is markdown*")
            Text("[click this link](http://fotosrodriguez.com) para ir a la web")
            
            Text("Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! Hello, world! ")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .padding()
                //.rotationEffect(.degrees(45), anchor: UnitPoint(x: 0.0, y: 0.0))
            
            //Star Wars effect:
                .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
                .shadow(color: .gray, radius: 2, x: 0, y: 15)
        }
        .padding()
    }
}

struct Texto_Previews: PreviewProvider {
    static var previews: some View {
        Texto()
    }
}
