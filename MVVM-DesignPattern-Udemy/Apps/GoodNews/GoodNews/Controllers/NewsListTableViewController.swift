//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 2/2/23.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    
    //    init(articleListVM: ArticleListViewModel) {
    //        self.articleListVM = articleListVM
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadData()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func loadData() {
        
        _ = "https://newsapi.org/v2/top-headlines"
        _ = "https://newsapi.org/v2/top-headlines?country=us&apiKey=427fadf7ee1c4d9185b142d260add28e"
        let urlBBC = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=427fadf7ee1c4d9185b142d260add28e"
        
        let url = URL(string: urlBBC)! //Force because is hard coded
        
        WebService().getArticles(url: url) { articles in
            
            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles)
                
                //Once we get the articles, we have to reaload the TableView
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }//END: loadData
    
    //Override methods for TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("La celda: ArticleTableViewCell no se encontro.")
        }
        
        let articleVM = self.articleListVM.articeAtIndex(indexPath.row)
        
        cell.titleLabel.text = articleVM.title ?? "sin datos"
        cell.descriptionLabel.text = articleVM.description ?? "sin datos"
        
        return cell
    }
}
