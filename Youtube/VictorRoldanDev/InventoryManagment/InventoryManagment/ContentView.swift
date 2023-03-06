//
//  ContentView.swift
//  InventoryManagment
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/3/23.
//

import SwiftUI

struct ContentView: View {
    
    private var arrayItemNavbar: [ItemNavbar.Model]
    
    init() {
        arrayItemNavbar = [
            ItemNavbar.Model(value: 421, description: "Overdue"),
            ItemNavbar.Model(value: 81, description: "to do"),
            ItemNavbar.Model(value: 72, description: "open"),
            ItemNavbar.Model(value: 51, description: "due today")
        ]
    }
    
    var body: some View {
        ZStack (alignment: .top){
            
            VStack {
                headerBackground
                Spacer()
            }
            
            navbarCustom
            
            VStack {
                Spacer()
                    .frame(height: 60)
                
                cardStatus
            }
        }
    }
    
    var headerBackground: some View {
        Rectangle()
            .fill(LinearGradient(colors: Constants.colorBlueGradiant,
                                 startPoint: .bottom,
                                 endPoint: .top))
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .mask({
                CustomRectangle() //Header curvado
            })
            .edgesIgnoringSafeArea(.top)
    }
    
    var navbarCustom: some View {
        VStack {
            HStack {
                Button {
                    print("Accion Boton 1")
                } label: {
                    Constants.imageHamburger
                        .font(.system(size: 25, weight: .bold))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                Spacer()
                
                Text("Inventory Management")
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
                
                Button {
                    print("Accion Boton 2")
                } label: {
                    Constants.imageAdd
                        .font(.system(size: 25, weight: .bold))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .foregroundColor(.white)
        }
    }
    
    var cardStatus: some View {
        HStack {
            ForEach(arrayItemNavbar.indices, id: \.self) { index in
                ItemNavbar(model: arrayItemNavbar[index])
                
                //Si es el ultimo item, no agrega el spacer
                if (arrayItemNavbar.endIndex - 1) != index{
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .shadow(color: .gray.opacity(0.5), radius: 15, x: 0, y: 0)
        .padding(.horizontal, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
