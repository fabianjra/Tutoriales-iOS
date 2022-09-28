//
//  TabViewCustom.swift
//  ComponentesSwiftUI
//
//  Created by z419617 on 26/7/22.
//

import SwiftUI

struct TabViewCustom: View {
    
    //Property Wrapper.
    @State public var selected: Int = 0
    
    var body: some View {
        
        //Se puede utilizar una vista externa.
        TabView(selection: $selected){
            Color.purple
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0) //Para manejar el index selected.
                .edgesIgnoringSafeArea(.top)
            
            FavoriteTabView(selected: $selected)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
                .tag(1)
                .edgesIgnoringSafeArea(.top)
            
            Color.blue
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Phone")
                }
                .tag(2)
                .edgesIgnoringSafeArea(.top)
            
            ToolbarView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
                .tag(3)
                .edgesIgnoringSafeArea(.top)
            
            //Cambia entre las vistas.
            //.Never quita los iconos en caso de que los tenga.
        }//.tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct TabViewCustom_Previews: PreviewProvider {
    static var previews: some View {
        TabViewCustom()
    }
}
