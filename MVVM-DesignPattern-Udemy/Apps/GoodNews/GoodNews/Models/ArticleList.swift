//
//  ArticleList.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 2/2/23.
//

//import Foundation

struct ArticleList: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Articles]?
}

struct Articles: Decodable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Decodable {
    let id: String?
    let name: String?
}
