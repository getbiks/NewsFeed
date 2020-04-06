//
//  ResponseFeed.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 05/04/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import Foundation

struct ResponseFeed : Codable {
    let status: String
    let code: String
    let message: String
}
