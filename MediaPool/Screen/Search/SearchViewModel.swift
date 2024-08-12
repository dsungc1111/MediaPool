//
//  SearchViewModel.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import Foundation
import RxSwift
import RxCocoa


protocol BaseViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}


final class SearchViewModel: BaseViewModel {
    
    enum UserDefaultKey: String {
        case result
    }
    
    private let disposeBag = DisposeBag()
    
    private var searchResultList: [String] = []
    
    struct Input {
        let searchClick: ControlEvent<Void>
        let searchWord: ControlProperty<String>
        let contentTap: ControlEvent<IndexPath>
        let trigger: PublishSubject<Void>
        let modelSelected: ControlEvent<String>
    }
    
    struct Output {
        let searchResult: PublishSubject<[Results]>
        let contentTap: ControlEvent<IndexPath>
        let searchList: BehaviorSubject<[String]>
        let searchItem: BehaviorSubject<String>
    }
    
    
    func transform(input: Input) -> Output {
        
        if let savedSearch = UserDefaults.standard.array(forKey: UserDefaultKey.result.rawValue) as? [String] {
            searchResultList = savedSearch
        }
        
        let searchResult = PublishSubject<[Results]>()
        
        let searchList = BehaviorSubject(value: searchResultList)
        
        input.trigger
            .subscribe(with: self) { owner, _ in
                searchList.onNext(owner.searchResultList)
            }
            .disposed(by: disposeBag)
        
        input.searchClick
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchWord)
            .subscribe(with: self) { owner, value in
                
                NetworkManager.shared.callRequest(query: value)
                    .subscribe(with: self) { owner, content in
                        searchResult.onNext(content.results)
                    }
                    .disposed(by: owner.disposeBag)
                
                for i in 0..<owner.searchResultList.count {
                    if owner.searchResultList[i] == value {
                        owner.searchResultList.remove(at: i)
                        break
                    }
                }
                owner.searchResultList.insert(value, at: 0)
                
                UserDefaults.standard.setValue(owner.searchResultList, forKey: UserDefaultKey.result.rawValue)
                
                searchList.onNext(owner.searchResultList)
            }
            .disposed(by: disposeBag)
        
        
        
        let modelSelected = BehaviorSubject(value: "")
        
        input.modelSelected
            .subscribe(with: self) { owner, value in
                
                modelSelected.onNext(value)
                
                NetworkManager.shared.callRequest(query: value)
                    .subscribe(with: self) { owner, content in
                        searchResult.onNext(content.results)
                    }
                    .disposed(by: owner.disposeBag)
                
                for i in 0..<owner.searchResultList.count {
                    if owner.searchResultList[i] == value {
                        owner.searchResultList.remove(at: i)
                        break
                    }
                }
                owner.searchResultList.insert(value, at: 0)
                
                UserDefaults.standard.setValue(owner.searchResultList, forKey: UserDefaultKey.result.rawValue)
                
                searchList.onNext(owner.searchResultList)
            }
            .disposed(by: disposeBag)
          
        
        
        return Output(searchResult: searchResult, contentTap: input.contentTap, searchList: searchList, searchItem: modelSelected )
        
    }
    
}
