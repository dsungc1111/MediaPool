//
//  DetailView.swift
//  MediaPool
//
//  Created by 최대성 on 8/9/24.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    
    
    let scrollView = UIScrollView()
    let representativeView = UIView()
    let appLogoView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        return view
    }()
    let appTitleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    let nameTitle = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    let downloadButton = {
        let btn = UIButton()
        btn.setTitle("받기", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.cornerRadius = 10
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .lightGray
        return btn
    }()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(representativeView)
        representativeView.addSubview(appLogoView)
        representativeView.addSubview(appTitleLabel)
        representativeView.addSubview(nameTitle)
        representativeView.addSubview(downloadButton)
    }
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        representativeView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(scrollView.safeAreaLayoutGuide)
            make.height.equalTo(120)
        }
        
        appLogoView.snp.makeConstraints { make in
            make.top.leading.equalTo(representativeView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(100)
        }
        downloadButton.snp.makeConstraints { make in
            make.bottom.equalTo(appLogoView.snp.bottom)
            make.leading.equalTo(appLogoView.snp.trailing).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        appTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(representativeView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(appLogoView.snp.trailing).offset(10)
            make.trailing.equalTo(representativeView.safeAreaLayoutGuide).inset(10)
        }
        nameTitle.snp.makeConstraints { make in
            make.top.equalTo(appTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(appLogoView.snp.trailing).offset(10)
            make.width.equalTo(200)
        }

    }
    
}
