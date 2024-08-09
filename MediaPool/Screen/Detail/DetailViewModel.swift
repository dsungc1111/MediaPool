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
    
    var element: Results = Results(trackName: "", artworkUrl100: "", artistName: "")
    
    
    let detailInfoResult = BehaviorSubject(value: Results(trackName: "", artworkUrl100: "", artistName: ""))
    
    private let disposeBag = DisposeBag()
    
    struct Output {
        let detailInfo: BehaviorSubject<Results>
    }
    
    func initialSetting() -> Output {
        detailInfoResult.onNext(element)
        return Output(detailInfo: detailInfoResult)
    }
    
    
    
}
