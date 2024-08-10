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
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
}
