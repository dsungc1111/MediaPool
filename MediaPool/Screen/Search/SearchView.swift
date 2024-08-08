//
//  SearchView.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let searchBar = UISearchBar()
    
    let tableView = UITableView()
    
    override func configureLayout() {
        addSubview(searchBar)
        addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
