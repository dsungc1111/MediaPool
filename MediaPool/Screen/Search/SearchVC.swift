//
//  SearchVC.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit
import SnapKit
import RxDataSources
import RxSwift
import RxCocoa
import Kingfisher

final class SearchVC: BaseVC {

    private let searchView = SearchView()
    
    private let viewModel = SearchViewModel()
    var newlist: [Results] = []
    override func loadView() {
        view = searchView
    }
    
    private let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "검색"
        
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchView.tableView.rowHeight = 80
        bind()
    }
    
    
    func bind() {
        
        let input = SearchViewModel.Input(
            searchClick:  searchView.searchBar.rx.searchButtonClicked,
            searchWord: searchView.searchBar.rx.text.orEmpty,
            contentTap: searchView.tableView.rx.itemSelected)
        
        let output = viewModel.transform(input: input)
        
        
        
        output.searchResult
            .bind(with: self) { owner, result in
                owner.newlist = result
            }
            .disposed(by: disposeBag)
      
        
        output.searchResult
            .bind( to: searchView.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                
                let url = element.artworkUrl100
                let image = URL(string: url)
                
                cell.thumbnail.kf.setImage(with: image)
                cell.contentTitle.text = element.trackName
            }
            .disposed(by: disposeBag)
        
        
       
        output.contentTap
            .bind(with: self) { owner, indexPath in
                
                let vc = DetailVC()
                vc.viewModel.element = owner.newlist[indexPath.row]
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by:  disposeBag)
        
    }


}
