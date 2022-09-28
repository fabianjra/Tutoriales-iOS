//
//  Estados.swift
//  ComponentesSwiftUI
//
//  Created by z419617 on 5/8/22.
//

import SwiftUI

struct StatesWrappers: View {
    
    //Permite asingar un valor  y que cuando tenga un cambio, notifica a las pantallas que dependan de el.
    //Apple recomienda que los States sean privados, porque deberian trabajar en esta unica vista.
    @State private var username: String = ""
    
    @State private var email: String = ""
    @State private var number: String = ""
    @State private var mostrarImagen: Bool = false
    
    //Stepper
    @State private var stepper: Int = 0
    let rango = 0...50 //Rango de numeros para los limites del stepp
    
    @State private var masTexto: String = ""
    
    var body: some View {
        
        VStack{
            
            //El form permite solamente un maximo de 10 componentes.
            Form{
                
                //El Section permite dividir componentes por cantidades para solventar el problema del Form de maximo 10 componentes.
                Section(header: Text("Segunda cabecera").foregroundColor(.red)){
                    //Se recibe un Binding (state), tiene la capacidad de ser alterado, incluso estando dentro de un Struct.
                    //El TextField debe permitir pasarle un valor que pueda ser modificado y leido al mismo tiempo, por eso se usa State.
                    //Se usa el simbolo dolar, solo para los componentes que requieran binding.
                    TextField("Nombre de usuario", text: $username)
                    
                    //Quien esté utilizando este valor, se actualiza automaticamente.
                    Text("Nombre: \(username)")
                    
                    
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    TextField("Email: ", text: $email)
                        .keyboardType(.emailAddress)
                    
                    TextField("Number: ", text: $number)
                        .keyboardType(.numberPad)
                }
                
                Section{
                    //El dolar se agrega porque el componente necesita un Binding para cambiar de valor la variable.
                    Toggle("Mostrar imagen", isOn: $mostrarImagen)
                    
                    //La variable de State solamente se llama para ver su valor, no necesita el dolar.
                    if(mostrarImagen){
                        Image(systemName: "envelope.circle.fill")
                            .font(.title)
                    }
                    
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    //Step: va a ir de 5 en 5
                    Stepper("Valor del step: \(stepper)", value: $stepper, in: rango, step: 5)
                    
                    
                    //Textos extensos:
                    TextEditor(text: $masTexto)
                }
                
        
                
            }
        }
        
        
    }
}

struct StatesWrappers_Previews: PreviewProvider {
    static var previews: some View {
        StatesWrappers()
    }
}
