//
//  ContentView.swift
//  SwiftDataTutorial
//
//  Created by Fabian Rodriguez on 29/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    //Permite guardar, borrar y obtener datos en la memoria de almacenamiento
    @Environment(\.modelContext) private var context
    
    //Query permite obtener el total de modelos que ya previamente se han almacenado.
    //@Query var countries: [CountryModel]
    
    //Ordernar el query.
    //Desventaja: El orden se realiza al momento de compilar, entonces no se puede luego re-ordernar la lista en base a otra prpiedad (ejem: nombre).
    @Query(sort: \CountryModel.code, order: .forward) var countries: [CountryModel]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(countries) { country in
                        Text("\(country.code) - \(country.name)")
                    }
                    .onDelete(perform: { indexSet in
                        //Obtiene el elemento con Force Unwrap porque esta seguro de que esta ahi.
                        let model = countries[indexSet.first!]
                        context.delete(model)
                    })
                }
                .navigationTitle("Country list")
                .toolbar {
                    
                    //Delete item
                    Button(action: {
                        
                        countries.forEach { countryModel in
                            context.delete(countryModel)
                        }

                    }, label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(Color.red)
                    })
                    
                    //Add item
                    Button(action: {
                        
                        let countryRandom = CountryModel.getRandomCountry()
                        context.insert(countryRandom) //Inserta al contexto
                        
                        //Si no tuviera AutoSaveEnabled, entonces se debe hacer manualmente:
                        //try context.save()
                        
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(Color.blue)
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
    //inMemory: Indica que la data que se va a manejar, va a ser en memoria, no guardada localmente en storage.
        .modelContainer(for: CountryModel.self, inMemory: true)
}
