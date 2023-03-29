//
//  NewsSourceListViewModel.swift
//  NewsApp
//
//  Created by Mohammad Azam on 6/30/21.
//

import Foundation

//Property wrapper: Se utiliza el "decorator" en la clase.
//MainActor indica que todas las propiedades y todas las funciones de esta clase, va a correr sobre el Main Thread.
@MainActor
class NewsSourceListViewModel: ObservableObject {
    
    @Published var newsSources: [NewsSourceViewModel] = []
    
    func getSources() async {
        
        do {
            //Usar el nuevo metodo con Callback
            let resNewSources = try await Webservice().fetchSources(url: Constants.Urls.sources)
                
                /*
                //Se llama en el Main Thread.
                //Si se utiliza el Property Wrapper "@MainActor", no hace falta el "DispatchQueue.main", porque ya lo MainActor se encarga de correr sobre el MainThread.
                DispatchQueue.main.async {
                 
                 //Se utiliza map, para convertir el resultado al tipo de modelo que se necesita en la respuesta.
                 self.newsSources = resNewSources.map(NewsSourceViewModel.init)
                }
                 */
                
            //Se llama sin el Dispatch.main, porque ya se está utilizando MainActor.
            //Se utiliza map, para convertir el resultado al tipo de modelo que se necesita en la respuesta.
            self.newsSources = resNewSources.map(NewsSourceViewModel.init)
            
        } catch {
            print("Error catch: \(error)")
        }
        
        // Ya no se llama a la funcion de utiliza completion, sino mas bien a la de sync funcion.
//        Webservice().fetchSources(url: Constants.Urls.sources) { result in
//            switch result {
//                case .success(let newsSources):
//                    DispatchQueue.main.async {
//                        self.newsSources = newsSources.map(NewsSourceViewModel.init)
//                    }
//                case .failure(let error):
//                    print(error)
//            }
//        }
    }
}

struct NewsSourceViewModel {
    
    fileprivate var newsSource: NewsSource
    
    var id: String {
        newsSource.id
    }
    
    var name: String {
        newsSource.name
    }
    
    var description: String {
        newsSource.description
    }
    
    static var `default`: NewsSourceViewModel {
        let newsSource = NewsSource(id: "abc-news", name: "ABC News", description: "This is ABC news")
        return NewsSourceViewModel(newsSource: newsSource)
    }
}
