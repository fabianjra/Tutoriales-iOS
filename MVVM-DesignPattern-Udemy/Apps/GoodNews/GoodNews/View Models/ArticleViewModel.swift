//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 6/2/23.
//

//ArticleViewModel: Es rsponsable de mostrar el "Article"
//Esto permite obtener el Article, pero es singular y en la respuesta viene una lista de Articles.
struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: String? {
        return self.article.title
    }
    
    var description: String? {
        return self.article.description
    }
}
