//
//  DetailViewModel.swift
//  MediaPool
//
//  Created by 최대성 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    
    var element: Results = Results(trackName: "", artworkUrl100: "", artistName: "", screenshotUrls: [], description: "", releaseNotes: "", genres: [], averageUserRatingForCurrentVersion: 0.0)
    
    
    let detailInfoResult = BehaviorSubject(value: Results(trackName: "", artworkUrl100: "", artistName: "", screenshotUrls: [""], description: "", releaseNotes: "", genres: [], averageUserRatingForCurrentVersion: 0.0))
    
    private let disposeBag = DisposeBag()
    
    struct Input {
//        let trigger: PublishSubject<Void>
    }
    
    struct Output {
        let detailInfo: BehaviorSubject<Results>
        let screenShot: BehaviorSubject<[String]>
    }
    
    func initialSetting() -> Output {
        
        
            
        detailInfoResult.onNext(element)
        
        let screenshotUrls = BehaviorSubject(value: [""])
        
        detailInfoResult
            .subscribe(with: self) { owner, value in
                screenshotUrls.onNext(value.screenshotUrls)
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(detailInfo: detailInfoResult, screenShot: screenshotUrls)
    }
    
    
    
}
