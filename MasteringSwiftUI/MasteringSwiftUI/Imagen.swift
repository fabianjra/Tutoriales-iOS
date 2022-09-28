//
//  Imagen.swift
//  MasteringSwiftUI
//
//  Created by Fabian Josue Rodriguez Alvarez on 23/9/22.
//

import SwiftUI

struct Imagen: View {
    var body: some View {
        
        VStack{
            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .shadow(color: .red, radius: 10, x: 0, y: 10)
                .opacity(0.5)
            
            Image("paris")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300)
                .clipped()
                //.clipShape(Circle())
                //.clipShape(Ellipse())
                .clipShape(Capsule())
                .overlay(
                    Image(systemName: "heart.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.green)
                        .opacity(0.5)
                )
                
        }
    }
}

struct Imagen_Previews: PreviewProvider {
    static var previews: some View {
        Imagen()
    }
}
