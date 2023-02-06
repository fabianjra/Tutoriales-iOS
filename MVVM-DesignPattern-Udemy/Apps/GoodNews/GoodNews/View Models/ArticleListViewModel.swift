//
//  ArticleListViewModel.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 6/2/23.
//

//Parent Model:
struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articeAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        
        return ArticleViewModel(article)
    }
}
