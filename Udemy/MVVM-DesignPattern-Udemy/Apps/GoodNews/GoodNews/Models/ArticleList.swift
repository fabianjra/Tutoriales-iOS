//
//  ArticleList.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 2/2/23.
//

struct ArticleList: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
