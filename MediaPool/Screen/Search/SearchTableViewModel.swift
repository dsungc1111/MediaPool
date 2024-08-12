//
//  SearchTableViewModel.swift
//  MediaPool
//
//  Created by 최대성 on 8/12/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchTableViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let downButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let text: PublishRelay<String>
    }
    
    func transform(input: Input) -> Output {
        
        let text = PublishRelay<String>()
        
        input.downButtonTap
            .map { "열기" }
            .bind(with: self) { owner, value in
                text.accept(value)
            }
            .disposed(by: disposeBag)
            
        return Output(text: text)
        
    }
}
