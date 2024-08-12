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
    let contentView = UIView()
    let appLogoView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        return view
    }()
    let appTitleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    let nameTitle = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()
    let downloadButton = {
        let btn = UIButton()
        btn.setTitle("받기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .systemBlue
        return btn
    }()
    let updateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "새로운 소식"
        return label
    }()
    let releaseLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let cellSpacing: CGFloat = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 330)
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        return layout
    }
    let descriptionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(DetailImageCollectionViewCell.self, forCellWithReuseIdentifier: DetailImageCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(appLogoView)
        contentView.addSubview(appTitleLabel)
        contentView.addSubview(nameTitle)
        contentView.addSubview(downloadButton)
        contentView.addSubview(updateLabel)
        contentView.addSubview(releaseLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(descriptionLabel)
    }
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        appLogoView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(100)
        }
        downloadButton.snp.makeConstraints { make in
            make.bottom.equalTo(appLogoView.snp.bottom)
            make.leading.equalTo(appLogoView.snp.trailing).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        appTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(appLogoView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        nameTitle.snp.makeConstraints { make in
            make.top.equalTo(appTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(appLogoView.snp.trailing).offset(10)
            make.width.equalTo(200)
        }
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(downloadButton.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).inset(20)
        }
        releaseLabel.snp.makeConstraints { make in
            make.top.equalTo(updateLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).inset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(350)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
}
