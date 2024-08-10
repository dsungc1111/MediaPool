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
   
    let tableView = UITableView()
    
    override func configureLayout() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
