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
    let cache               = NSCache<NSString, UIImage>()
    private let baseURL     = "https://newsapi.org/v2/everything?apiKey="
    private let apiKey      = "3145d60eaf18468ea2a92b6875f9cb51"
    private let pageSize    = "10"
        
    private init() {}
    
    func GetNewsFeed(language : String, page : Int, completed: @escaping (NewsFeed?, String?) -> Void) {
        
        if apiKey.isEmpty {
            completed(nil, ErrorMessages.apiKeyMissing.rawValue)
            return
        }
        
        let endPointURL = baseURL + apiKey + "&q=google&language=\(language)&pageSize=\(pageSize)&page=\(page)"
        
        guard let url = URL(string: endPointURL) else {
            completed(nil, ErrorMessages.invalidURL.rawValue)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, ErrorMessages.checkInternet.rawValue)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, ErrorMessages.invalidServerResponse.rawValue)
                return
            }
            
            guard let data = data else {
                completed(nil, ErrorMessages.invalidData.rawValue)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let feed = try decoder.decode(NewsFeed.self, from: data)
                completed(feed, nil)
            } catch {
                completed(nil, ErrorMessages.decodeError.rawValue)
            }
        }
        
        task.resume()
    }
    
    func DownloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void){
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
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
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
}
