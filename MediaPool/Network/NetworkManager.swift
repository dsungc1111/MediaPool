//
//  NetworkManager.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import Foundation
import RxSwift

struct Results: Decodable {
    let trackName: String
    let artworkUrl100: String
}

struct Content: Decodable {
    let results: [Results]
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callRequest(query: String) -> Observable<Content> {
        
        let url =  "https://itunes.apple.com/search?term=\(query)"
        
        let request = URL(string: url)!
        
        
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
