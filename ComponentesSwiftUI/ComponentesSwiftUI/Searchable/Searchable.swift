//
//  Searchable.swift
//  ComponentesSwiftUI
//
//  Created by z419617 on 16/8/22.
//

import SwiftUI

//Capa Modelo:
struct CountriesModel: Codable {
    let name: String
    let code: String
    
    static func loadJson() -> [CountriesModel]? {
        
        guard let url = Bundle.main.url(forResource: "Countries", withExtension: "json") else {
            return nil
        }
        
        do{
            let data = try Data(contentsOf: url)
            let countries = try JSONDecoder().decode([CountriesModel].self, from: data)
            
            return countries
            
        }catch{
            return nil
        }
    }
}

//Capa ViewModel
class ViewModel: ObservableObject {
    
    @Published var countries = [CountriesModel]()
    
    init() {
        //En caso de no tener datos, deja vacio.
        countries = CountriesModel.loadJson() ?? []
    }
}

//Capa Vista:
struct Searchable: View {
    
    @ObservedObject private var viewModel = ViewModel()
    @State private var searchText: String = ""
    
    //Forma de guardar un contenido en una variable, con logica interna.
    var results:[CountriesModel]{
        if searchText.isEmpty {
            return viewModel.countries
        }else{
            //La posicion cero: $0
            //Busque el contenido que contenga SearchText.
            return viewModel.countries.filter{$0.name.uppercased()
                    .contains(searchText.uppercased())
            }
        }
    }
    
    var body: some View {
        
        NavigationView{
            
            List{
                Section{
                    ForEach(results, id: \.code) { result in
                        
                        HStack{
                            Text(result.code)
                            Text(result.name)
                            Text(flag(country: result.code))
                        }
                    }
                }
            }
            //$seachText: Tiene la capacidad de escribir en la variable y leerla al mismo tiempo, por ser binding.
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: Text("Escribe el nombre"))
            .navigationTitle("Paises")
            .listStyle(.plain)
        }
    }
}

//Logica para convertir codigo de pais a imagen de bandera
private func flag(country: String) -> String {
    let base:UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(s)
}

struct Searchable_Previews: PreviewProvider {
    static var previews: some View {
        Searchable()
    }
}
