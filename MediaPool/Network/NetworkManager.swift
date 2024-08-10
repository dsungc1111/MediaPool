//
//  NetworkManager.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import Foundation
import RxSwift
import Differentiator



struct Results: Decodable {
    let trackName: String // 앱 이름
    let artworkUrl100: String // 앱 사진
    let artistName: String // 회사 이름
    let screenshotUrls: [String]
    let description: String
    let releaseNotes: String
    let genres: [String]
    let averageUserRatingForCurrentVersion: Double
}

struct Content: Decodable {
    let results: [Results]
}




final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callRequest(query: String) -> Observable<Content> {
        
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
        
        let result = Observable<Content>.create { observer in
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard error == nil else {
                    print("에러임")
                    return
                }
                
                guard let data = data else {
                    print("데이터 이상해")
                    return
                }
                guard let response = response as? HTTPURLResponse else  {
                    print("응답에러")
                    return
                }
                guard response.statusCode == 200 else {
                    print("statuscode 200 X")
                    return
                }
                
                if let content = try? JSONDecoder().decode(Content.self, from: data) {
                    observer.onNext(content)
                    observer.onCompleted()
                }
            }.resume()
            
            return Disposables.create()
        }
        
        return result
        
        
    }
    
}
