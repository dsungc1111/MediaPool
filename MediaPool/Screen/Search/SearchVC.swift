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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "검색"
        bind()
    }
    
    
    func bind() {
        let a = searchView.searchBar.rx.searchButtonClicked
        
        // 옵져버블 > 컨트롤 이벤트
//        let controlEvent = ControlEvent<Void>(events: 오1\ㅂ져버블)
    }

    

}
