//
//  Article.swift
//  GoodNews
//
//  Created by Fabian Josue Rodriguez Alvarez on 6/2/23.
//

struct Article: Decodable {
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
