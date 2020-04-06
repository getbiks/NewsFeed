//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

enum versionError: Error {
    case invalidResponse, invalidBundleInfo
}

class NetworkManager {
    static let shared       = NetworkManager()
    let imageCache          = NSCache<NSString, UIImage>()
    private let baseURL     = "https://newsapi.org/v2"
    private let apiKey      = "3145d60eaf18468ea2a92b6875f9cb51"
    private let pageSize    = "20"
        
    private init() {}
    
    func GetNewsFeed(keyword: String, language : String, fromDate: String, toDate: String,page : Int, completed: @escaping (Result<NewsFeed, ErrorMessages>) -> Void) {
        
        if apiKey.isEmpty {
            completed(.failure(.apiKeyMissing))
            return
        }
        let sortType = ["publishedAt","popularity","relevancy"]
        let newsType = ["everything", "top-headlines", "sources"]
        //let source = "abc-news"
        //let category = ["Business","Entertainment","Health","Science","Sports","Technology"]
        let news = "/\(newsType[0])?"
        let api = "apiKey=\(apiKey)"
        let parameters = "&q=\(keyword)&from=\(fromDate)&to=\(toDate)&sortBy=\(sortType[0])&language=\(language)&pageSize=\(pageSize)&page=\(page)"
        let endPointUrl = baseURL + news + api + parameters
        print(endPointUrl)
        guard let url = URL(string: endPointUrl) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.checkInternet))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
                        
            let response = response as? HTTPURLResponse
            
            do {
                let decoder = JSONDecoder()
                if response?.statusCode != 200 {
                    let responseFeed = try decoder.decode(ResponseFeed.self, from: data)
                    let code = responseFeed.code
                    if code == "apiKeyInvalid" {
                        completed(.failure(.apiKeyInvalid))
                    } else if code == "apiKeyDisabled" {
                        completed(.failure(.apiKeyDisabled))
                    } else if code == "apiKeyExhausted" {
                        completed(.failure(.apiKeyExhausted))
                    }
                    return
                } else {
                    let feed = try decoder.decode(NewsFeed.self, from: data)
                    completed(.success(feed))
                }
            } catch {
                completed(.failure(.decodeError))
            }
        }
        
        task.resume()
    }
    
    func DownloadImage(urlString: String, hashString: String, completed: @escaping (UIImage?) -> Void){
        let cacheKey = NSString(string: hashString)
        if let image = imageCache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            self.imageCache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
