//
//  NewsArticleListViewModel.swift
//  NewsApp
//
//  Created by Mohammad Azam on 6/30/21.
//

import Foundation

//Property wrapper: Se utiliza el "decorator" en la clase.
//MainActor indica que todas las propiedades y todas las funciones de esta clase, va a correr sobre el Main Thread.
@MainActor
class NewsArticleListViewModel: ObservableObject {
    
    @Published var newsArticles = [NewsArticleViewModel]()
    
    func getNewsBy(sourceId: String) async {
        
        //Actualizacion de la logica que llama a la funcion con async.
        do{
            let newsArticles = try await Webservice().fetchNewsAsync(sourceId: sourceId, url: Constants.Urls.topHeadlines(by: sourceId))
            
            /*
            //Se llama en el Main Thread.
            //Si se utiliza el Property Wrapper "@MainActor", no hace falta el "DispatchQueue.main", porque ya lo MainActor se encarga de correr sobre el MainThread.
            DispatchQueue.main.async {
                self.newsArticles = newsArticles.map(NewsArticleViewModel.init)
            }
             */
            
            //Se llama sin el Dispatch.main, porque ya se está utilizando MainActor.
            self.newsArticles = newsArticles.map(NewsArticleViewModel.init)
            
        } catch {
            debugPrint(error)
        }
        
        /*
        Webservice().fetchNews(by: sourceId, url: Constants.Urls.topHeadlines(by: sourceId)) { result in
            switch result {
                case .success(let newsArticles):
                    DispatchQueue.main.async {
                        self.newsArticles = newsArticles.map(NewsArticleViewModel.init)
                    }
                case .failure(let error):
                    print(error)
            }
        }
         */
    }
}

struct NewsArticleViewModel {
    
    let id = UUID()
    fileprivate let newsArticle: NewsArticle
    
    var title: String {
        newsArticle.title
    }
    
    var description: String {
        newsArticle.description ?? ""
    }
    
    var author: String {
        newsArticle.author ?? ""
    }
    
    var urlToImage: URL? {
        URL(string: newsArticle.urlToImage ?? "")
    }
    
}
