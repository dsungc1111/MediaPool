//
//  SearchViewModel.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchClick: ControlEvent<Void>
        let searchWord: ControlProperty<String>
    }
    
    struct Output {
        let searchResult: PublishSubject<[Results]>
    }
    
    
    func transform(input: Input) -> Output {
        
        var searchResult = PublishSubject<[Results]>()
        
        input.searchClick
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchWord)
            .subscribe(with: self) { owner, value in
                NetworkManager.shared.callRequest(query: value)
                    .subscribe(with: self) { owner, content in
                        searchResult.onNext(content.results)
                    }
                    .disposed(by: owner.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        return Output(searchResult: searchResult )
        
    }
    
}
