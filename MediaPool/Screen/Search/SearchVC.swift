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
        
        
        output.searchList
            .bind(to: searchView.collectionView.rx.items(cellIdentifier: SearchCollectionViewCell.identifier, cellType: SearchCollectionViewCell.self)) { (row, element, cell) in
                
                
                cell.resultButton.setTitle(element, for: .normal)
                
            }
            .disposed(by: disposeBag)
        
        
        
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
                cell.companyLabel.text = element.artistName
                if let genre = element.genres.first {
                    cell.genreLabel.text = genre
                }
                let grade = String(format: "%.2f", element.averageUserRatingForCurrentVersion)
                cell.gradeLabel.setTitle( " \(grade)", for: .normal)
                let screenShoturl = element.screenshotUrls
                
                
                let first = screenShoturl[0]
                var preview = URL(string: first)
                cell.firstPreview.kf.setImage(with: preview)
                let second = screenShoturl[1]
                preview = URL(string: second)
                cell.secondPreview.kf.setImage(with: preview)
                let third = screenShoturl[2]
                preview = URL(string: third)
                cell.thirdPreview.kf.setImage(with: preview)
                
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
