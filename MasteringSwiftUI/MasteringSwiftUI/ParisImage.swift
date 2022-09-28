//
//  ParisImage.swift
//  MasteringSwiftUI
//
//  Created by Fabian Josue Rodriguez Alvarez on 23/9/22.
//

import SwiftUI

struct ParisImage: View {
    var body: some View {
        
        VStack{
            Image("paris")
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .overlay(
//
//                )
        }
    }
}

struct ParisImage_Previews: PreviewProvider {
    static var previews: some View {
        ParisImage()
    }
}
