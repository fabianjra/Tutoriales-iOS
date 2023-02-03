//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 2/2/23.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadData()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func loadData() {
        
        let errorExample = "https://newsapi.org/v2/top-headlines"
        let urlCountryUS = "https://newsapi.org/v2/top-headlines?country=us&apiKey=427fadf7ee1c4d9185b142d260add28e"
        let urlBBC = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=427fadf7ee1c4d9185b142d260add28e"
        
        let url = URL(string: urlBBC)! //Force because is hard coded

        WebService().getArticles(url: url) { _ in
            
        }
    }
}
