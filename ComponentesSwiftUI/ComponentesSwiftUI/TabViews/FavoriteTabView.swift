//
//  FavoriteTabView.swift
//  ComponentesSwiftUI
//
//  Created by z419617 on 26/7/22.
//

import SwiftUI

struct FavoriteTabView: View {
    
    @Binding public var selected: Int
    
    var body: some View {
        ZStack{
            Color.gray
            
            Button{
                selected = 3
            } label: {
                Text("Ir a Profile")
            }
        }
        
    }
}

struct FavoriteTabView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteTabView(selected: .constant(0))
    }
}
