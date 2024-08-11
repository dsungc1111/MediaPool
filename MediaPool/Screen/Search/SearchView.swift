//
//  SearchView.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let searchController = UISearchController(searchResultsController: nil)
   
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 35)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureLayout() {
        addSubview(collectionView)
        addSubview(tableView)
        
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(5)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(5)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
}
