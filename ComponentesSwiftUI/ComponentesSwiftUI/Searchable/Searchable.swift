//
//  Searchable.swift
//  ComponentesSwiftUI
//
//  Created by z419617 on 16/8/22.
//

import SwiftUI

//Capa Modelo:
//Codable protocol is composed of Encodable and Decodable.

/*
 Encoding The process of converting your custom type instances to other representation such as JSON and pList is known as Encoding or Serialization. For encoding, custom types conform to Encodable protocol.

 Decoding The process of converting data in representation such as JSON or pList to instance of your custom type is known as Decoding or Deserialization. For decoding, custom types conform to Decodable protocol.

 Codable To support both encoding and decoding, custom types can conform to Codable protocol which conforms to both Encodable and Decodable.
 
 to Read more about Codable, Decoding and Encoding:
 https://medium.com/@manojkarkie/encodable-and-decodable-in-swift-4-747328a7c7c5
 */
struct CountriesModel: Decodable {
    let nameCountry: String
    let codeCountry: String
    
    enum CodingKeys: String, CodingKey {
        case nameCountry = "name"
        case codeCountry = "code"
    }
    
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
            return viewModel.countries.filter{$0.nameCountry.uppercased()
                    .contains(searchText.uppercased())
            }
        }
    }
    
    var body: some View {
        
        NavigationView{
            
            List{
                Section{
                    ForEach(results, id: \.codeCountry) { result in
                        
                        HStack{
                            Text(result.codeCountry)
                            Text(result.nameCountry)
                            Text(flag(country: result.codeCountry))
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
