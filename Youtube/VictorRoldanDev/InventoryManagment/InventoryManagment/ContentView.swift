//
//  ContentView.swift
//  InventoryManagment
//
//  Created by Fabian Josue Rodriguez Alvarez on 5/3/23.
//

import SwiftUI

struct ContentView: View {
    
    private var arrayItemNavbar: [ItemNavbar.Model]
    private var arrayCards: [Card.Model]
    
    init() {
        arrayItemNavbar = [
            ItemNavbar.Model(value: 77, description: "Overdue"),
            ItemNavbar.Model(value: 81, description: "to do"),
            ItemNavbar.Model(value: 72, description: "open"),
            ItemNavbar.Model(value: 51, description: "due today")
        ]
        
        arrayCards = [
            Card.Model(type: .asset,
                       status: .open,
                       title: "Request for a new Apple Macbook Pro",
                       owner: "Fabian Rodriguez",
                       time: "2m"),
            Card.Model(type: .asset,
                       status: .accepted,
                       title: "Request for new table",
                       owner: "Josue Alvarez",
                       time: "16m"),
            Card.Model(type: .troubleshoot,
                       status: .onHold,
                       title: "Pago de planillas",
                       owner: "Fabio Alvarado",
                       time: "50m"),
            Card.Model(type: .asset,
                       status: .inProgress,
                       title: "Chair for users",
                       owner: "Fabian Rodriguez",
                       time: "40m"),
            Card.Model(type: .troubleshoot,
                       status: .solved,
                       title: "Request for laptop",
                       owner: "Josue Alvarez",
                       time: "6d")
        ]
    }
    
    //TODO: General -> Pasar valores a archivo de constantes.
    
    var body: some View {
        ZStack (alignment: .top){
            
            VStack {
                headerBackground
                Spacer()
            }
            
            navbarCustom
            
            VStack {
                Spacer()
                    .frame(height: 60) //Espacio entre el TopView y la barra de cardStatus
                
                cardStatus
                
                sectionTitle
                
                List(arrayCards) { item in
                    Card(model: item)
                }
                .padding(.horizontal, 0)
                .listStyle(.plain)
            }
        }
        
        /*
         //Otra manera de cargar la pantalla, haciendole un onAppear al ZStack
         .onAppear{
         arrayCards = Model.getItems() //Funcion para cargar el modelo de datos
         
         //Repetir el array para tener mas items para la vista:
         arrayCards = Array(repeating: model.getItems(), count 10).flatMap{ $0 }
         }
         */
    }
    
    var headerBackground: some View {
        Rectangle()
            .fill(LinearGradient(colors: Constants.Colors.lightBlueGradiant,
                                 startPoint: .top,
                                 endPoint: .bottom))
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
                    Constants.Images.hamburger
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
                    //TODO: Agregar accion para agregar una Card.
                } label: {
                    Constants.Images.add
                        .font(.system(size: 25, weight: .bold))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .foregroundColor(.white)
        }
    }
    
    var cardStatus: some View {
        
        //TODO: Ajustar el espacer o frame, para igualar los tamaños y no depender del contenido de cada ItemNavbar.
        //TODO: Agregar accion de filtrado a las cards.
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
    
    var sectionTitle: some View {
        HStack {
            Text("Due today")
            
            Spacer()
            
            HStack {
                Text("Sort by")
                
                Button {
                    print("Sort by presionado")
                    //TODO: Agregar la accion de ordenamiento
                } label: {
                    Constants.Images.sort
                }
            }
        }
        .padding(.top, 20)
        .foregroundColor(Color.black.opacity(0.5))
        .padding(.horizontal, 20)
    }
    
}//End: ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
