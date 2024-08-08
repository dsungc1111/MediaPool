//
//  SearchView.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit

final class SearchView: BaseView {
    
    let searchBar = UISearchBar()
    
    
    override func configureLayout() {
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
}
