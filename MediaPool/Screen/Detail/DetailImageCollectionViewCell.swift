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
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        return image
    }()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        imageView.backgroundColor = .systemBlue
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    func configureCell(element: String) {
        let imageUrl = URL(string: element)
        imageView.kf.setImage(with: imageUrl)
    }
    
}
