//
//  ToolbarView.swift
//  ComponentesSwiftUI
//
//  Created by z419617 on 28/7/22.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack{
                    
                    ForEach(0..<20){ item in
                        Text("Item numero: \(item)")
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity) //Para que se pegue a los lados.
                            .padding(.horizontal)
                    }
                }
                .navigationTitle("Lista de objetos")
                
                //Por defecto está en automatico, pero con inline, siempre se va a mostrar el titulo arriba.
                .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    
                    //Los toolbarItem recibe cualquier vista.
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            //Aqui se le agrega la accion al boton.
                            print("Hola Usuario")
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {}) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {}) {
                            Image(systemName: "folder.badge.plus")
                        }
                    }
                    
                    //Si no estuviera este item, se le coloca al titulo, el del NavigationTitle.
                    ToolbarItem(placement: .principal){
                        Text("Bienvenido")
                    }
                    
                    //BottonBar: Permite poner un boton al pie de la pantalla.
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {}) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
            }
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}
