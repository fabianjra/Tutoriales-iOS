//
//  SwiftDataTutorialApp.swift
//  SwiftDataTutorial
//
//  Created by Fabian Rodriguez on 29/11/23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTutorialApp: App {
    
    // MARK: Primer forma de container:
    
    //Se crea un container personalizado:
    let container1: ModelContainer = {
        var container: ModelContainer!
        
        //Crear un path personalizado para el directorio en donde se va a guardar el container.
        //Se le indica como se va a llamar la base de datos o Container.
        //La extension de .store es obligatorio, porque es la de la base de datos.
        //Documents directory es la carpeta de Documents en Mac, puede usarse cualquier otra ruta.
        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "CountryModel.store"))
        
        do {
            container = try ModelContainer(for: CountryModel.self, configurations: config)
        } catch {
            debugPrint("Error al capturar el container de la BD")
        }
        
        return container
    }()
    
    
    // MARK: Segunda forma de container, con Schema:
    
    let container2: ModelContainer = {
        var container: ModelContainer!
        
        //Se crea un squema con un array. Solo tenemos un modelo, entonces se usa el de Country Model.
        let schema = Schema([CountryModel.self])
        
        //Primer parametro: Nombre para identificarlo.
        let config = ModelConfiguration("CountryModelSchema",
                                        schema: schema,
                                        isStoredInMemoryOnly: false,
                                        allowsSave: true)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            debugPrint("Error al capturar el container de la BD")
        }
        
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        //Le indica a la vista que va a trabajar con CountryModel.
        //Puede ser un array seprado por comas. EJEM: [CountryModel.self, UserModel.self, etc...]
        //.modelContainer(for: CountryModel.self)
        
        //Ahora s ele pasa durectamente el container que se instancio.
        .modelContainer(container2)
    }
    
    init() {
        //Permite saber donde esta ubicada la base de datos
        debugPrint("Ubicacion de la base de datos SQL:")
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        
        //Obtener el directorio en donde esta la base de datos que se creo para Country
        debugPrint("Ubicacion de la base de datos manual. Container 1:")
        print(URL.documentsDirectory.path(percentEncoded: false))
        
        
        debugPrint("Ubicacion de la base de datos manual. Container 2 (utilizando directorio por defecto:")
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
