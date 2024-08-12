//
//  NetworkManager.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import Foundation
import RxSwift
import Differentiator

enum NetworkError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
    case invalidURL
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callRequest(query: String) -> Single<Content> {
        
//        let url =  "https://itunes.apple.com/search?term=\(query)&media=software"
        //        let request = URL(string: url)!
        
        var component = URLComponents()
        component.scheme = "https"
        component.host = "itunes.apple.com"
        component.path = "/search"
        component.queryItems = [
            URLQueryItem(name: "term", value: query),
            URLQueryItem(name: "media", value: "software"),
            URLQueryItem(name: "country", value: "KR")
        ]
        
        
        let request = URLRequest(url: component.url!)
        
        let result = Single<Content>.create { observer in
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
             
                if let error = error {
                    observer(.failure(NetworkError.failedRequest))
                }
                
                guard let data = data else {
                    observer(.failure(NetworkError.invalidData))
                    return
                }
                guard let response = response as? HTTPURLResponse else  {
                    observer(.failure(NetworkError.invalidResponse))
                    return
                }
                guard response.statusCode == 200 else {
                    observer(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if let content = try? JSONDecoder().decode(Content.self, from: data) {
                    observer(.success(content))
                }
            }.resume()
            
            return Disposables.create()
        }
        
        return result
        
        
    }
    
}
