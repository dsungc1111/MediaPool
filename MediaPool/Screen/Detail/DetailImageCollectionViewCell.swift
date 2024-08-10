//
//  DetailImageCollectionViewCell.swift
//  MediaPool
//
//  Created by 최대성 on 8/10/24.
//

import UIKit
import SnapKit
import RxSwift

final class DetailImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailImageCollectionViewCell"
    
    let imageView = {
        let view = UIImageView()
        
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
}
