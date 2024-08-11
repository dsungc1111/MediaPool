//
//  SearchCollectionViewCell.swift
//  MediaPool
//
//  Created by 최대성 on 8/11/24.
//

import UIKit
import SnapKit
import RxSwift

final class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    let resultButton = {
        let btn = UIButton()
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        contentView.addSubview(resultButton)
        
        resultButton.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    
    
}
