//
//  ObservablesWrappers.swift
//  ComponentesSwiftUI
//
//  Created by z419617 on 5/8/22.
//

import SwiftUI

//Modelo a utilizar (Capa Model)
struct PostModel : Decodable{
    //Se podria agregar el Identifable, pero ya el API proporciona un ID.
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

//ViewModel a utilizar (Capa: ViewModel)
//Para poder utilizar el "Publised", se necesita el proyocolo de ObervableObject.
class postViewModel : ObservableObject{
    
    //Dispara la informacion a quien este suscrito.
    @Published var postList = [PostModel]()
    
    func initialize() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
            return
        }
        
        do{
            //data: Trae los datos
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //Convierte la data (json obtenido) y la mapea al Modelo.
            if let response = try? JSONDecoder().decode([PostModel].self, from: data){
                DispatchQueue.main.async {
                    self.postList = response
                }
            }
            
        }catch{
            print("Error: ", error)
        }
    }
}

struct ObservablesWrappers: View {
    
    //Se instancia el ViewModel
    //El property Wrapper "ObservedObject", permite leer lo del API.
    //Esta instancia está atenta a los cambios que sucedan, gracias al Wrapper.
    @ObservedObject var viewModel = postViewModel()
    
    var body: some View {
        
        List{
            //Para un rango cerrado, se debe utilizar "id".
            //ForEach(1...100, id: \.self){ item in
            
            ForEach(viewModel.postList, id: \.id) { item in
                
                VStack(alignment: .leading){
                    Text("valor: \(item.title)")
                        .bold() 
                    
                    Text("valor: \(item.body)")
                        .font(.caption)
                }
            }
        }
        //Permite llamar una funcion cuando se meustre la lista.
        .onAppear(){
            
            //Se utiliza Task porque es Asincrono.
            Task {
                await viewModel.initialize()
            }
        }
    }
}

struct ObservablesWrappers_Previews: PreviewProvider {
    static var previews: some View {
        ObservablesWrappers()
    }
}
