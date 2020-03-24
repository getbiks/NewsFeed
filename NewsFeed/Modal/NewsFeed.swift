//
//  NewsFeed.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import Foundation

struct NewsFeed : Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article : Codable {
    var source: Source
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
}

struct Source : Codable {
    var id: String?
    var name: String?
}
