//
//  DetailVC.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit
import SnapKit

final class DetailVC: BaseVC {

    
    let scrollView = UIScrollView()
    let representativeView = UIView()
    
    var element: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        print(element)
    }
    
    
    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(representativeView)
        representativeView.backgroundColor = .lightGray
    }
    func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        representativeView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(scrollView.safeAreaLayoutGuide)
        }
    }

}
