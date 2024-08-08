//
//  SearchVC.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchVC: BaseVC {

    private let searchView = SearchView()
    
    private let viewModel = SearchViewModel()
    
    override func loadView() {
        view = searchView
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "검색"
        
        bind()
    }
    
    
    func bind() {
        
        let input = SearchViewModel.Input(searchClick:  searchView.searchBar.rx.searchButtonClicked, searchWord: searchView.searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
       
        
        
        
    }

    

}
