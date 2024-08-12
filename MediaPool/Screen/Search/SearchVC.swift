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
    
    private var newlist: [Results] = []
    
    private let realmManager = RealmManager()
    
    override func loadView() {
        view = searchView
    }
    
    private let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "검색"
        searchView.searchController.searchBar.placeholder = "검색어를 입력해주세요."
        self.navigationItem.searchController = searchView.searchController
        
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchView.tableView.rowHeight = 320
        
    }
    
    
    override func bind() {
        
        let trigger = PublishSubject<Void>()
        
        let input = SearchViewModel.Input(
            searchClick:  searchView.searchController.searchBar.rx.searchButtonClicked,
            searchWord: searchView.searchController.searchBar.rx.text.orEmpty,
            contentTap: searchView.tableView.rx.itemSelected, trigger: trigger, modelSelected: searchView.collectionView.rx.modelSelected(String.self))
        
        
        let output = viewModel.transform(input: input)
        
        // MARK: - 검색기록
        output.searchList
            .bind(to: searchView.collectionView.rx.items(cellIdentifier: SearchCollectionViewCell.identifier, cellType: SearchCollectionViewCell.self)) { (row, element, cell) in
                cell.resultButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        
        // MARK: - 검색결과 어플 보여주는 용도
        output.searchResult
            .bind(with: self) { owner, result in
                owner.newlist = result
            }
            .disposed(by: disposeBag)
      
        
        output.searchResult
            .bind(to: searchView.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                
                cell.configureCell(element: element)
                
                let cellViewModel = searchCellViewModel()
                
                let cellInput = searchCellViewModel.Input(cellTap: cell.downloadButton.rx.tap, cellElement: Observable.just(element))
                
                let cellOutput = cellViewModel.cellTransform(input: cellInput)
                
                cellOutput.text
                    .bind(to: cell.downloadButton.rx.title())
                    .disposed(by: cell.disposeBag)
                
//                let a = cell.downloadButton.rx.tap
//                    .subscribe(with: self) { owner, _ in
//                        owner.realmManager.saveApp(element: element)
//                        cell.downloadButton.setTitle("열기", for: .normal)
//                    }
//                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        // MARK: - 컨텐츠 클릭시 화면 전환
       
        output.contentTap
            .bind(with: self) { owner, indexPath in
                
                let vc = DetailVC()
                vc.viewModel.element = owner.newlist[indexPath.row]
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by:  disposeBag)
        
        
        output.searchItem
            .bind(with: self) { owner, searchItem in
                owner.searchView.searchController.searchBar.text = searchItem
            }
            .disposed(by: disposeBag)
    }
}
