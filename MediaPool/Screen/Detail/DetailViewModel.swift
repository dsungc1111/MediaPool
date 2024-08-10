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
    
    struct Output {
        let detailInfo: BehaviorSubject<Results>
    }
    
    func initialSetting() -> Output {
        detailInfoResult.onNext(element)
        return Output(detailInfo: detailInfoResult)
    }
    
    
    
}
