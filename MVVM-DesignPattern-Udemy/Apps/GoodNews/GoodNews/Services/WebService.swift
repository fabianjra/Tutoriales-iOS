//
//  WebService.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 2/2/23.
//

import Foundation

class WebService {
    
    func getArticles(url: URL, completion: @escaping ([Articles]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                Log.WriteCatchExeption(err: error)
                completion(nil)
                
            }else if let data = data {
                
                let decoder = JSONDecoder()
                
                do{
                    //el valor "data" contiene los datos consutlados. Aqui trata de transformarlo con el decoder, al tipo de objeto que se esta esperando.
                    let articleList = try decoder.decode(ArticleList.self, from: data).articles
                    
                    if let articleList = articleList {
                        completion(articleList)
                    }
                    
                    articleList?.forEach({ item in
                        print("Mapeado: \(item)")
                    })
                    
                }catch{
                    Log.WriteCatchExeption(err: error)
                    //throw NetworkError.couldNotDecodeData
                }
            }
        }.resume() //Inicia la ejecucion.
    }
}
