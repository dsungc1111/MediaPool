//
//  CellViewModel.swift
//  MediaPool
//
//  Created by 최대성 on 8/13/24.
//

import Foundation
import RxSwift
import RxCocoa

final class searchCellViewModel {
    
    private let realmManager = RealmManager()
    
    struct Input {
        let cellTap: ControlEvent<Void>
        let cellElement: Observable<Results>
    }
    
    struct Output {
        let text: PublishRelay<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func cellTransform(input: Input) -> Output {
        
        let text = PublishRelay<String>()
    
    
        
        input.cellTap
            .withLatestFrom(input.cellElement)
            .subscribe(with: self) { owner, result in
                print(result.trackName)
                owner.realmManager.saveApp(element: result)
                text.accept("열기")
            }
            .disposed(by: disposeBag)
     
        
        return Output(text: text)
    }
    
}
