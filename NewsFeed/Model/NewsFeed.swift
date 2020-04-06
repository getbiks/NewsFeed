//
//  NewsFeed.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import Foundation

struct NewsFeed : Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article : Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source : Codable {
    let id: String?
    let name: String?
}
