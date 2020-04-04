//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared       = NetworkManager()
    let imageCache               = NSCache<NSString, UIImage>()
    private let baseURL     = "https://newsapi.org/v2"
    private let apiKey      = "3145d60eaf18468ea2a92b6875f9cb51"
    private let pageSize    = "10"
        
    private init() {}
    
    func GetNewsFeed(keyword: String, language : String, page : Int, completed: @escaping (Result<NewsFeed, ErrorMessages>) -> Void) {
        
        if apiKey.isEmpty {
            completed(.failure(.apiKeyMissing))
            return
        }
                
        let endPointURLEverything = baseURL + "/everything?apiKey=\(apiKey)&q=\(keyword)&sortBy=publishedAt&language=\(language)&pageSize=\(pageSize)&page=\(page)"
        print(endPointURLEverything)
        
        guard let url = URL(string: endPointURLEverything) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.checkInternet))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidServerResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let feed = try decoder.decode(NewsFeed.self, from: data)
                completed(.success(feed))
            } catch {
                completed(.failure(.decodeError))
            }
        }
        
        task.resume()
    }
    
    func DownloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void){
        let cacheKey = NSString(string: urlString)
        if let image = imageCache.object(forKey: cacheKey){
            completed(image)
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
