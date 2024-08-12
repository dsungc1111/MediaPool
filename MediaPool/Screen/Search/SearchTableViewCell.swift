//
//  SearchTableViewCell.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit
import SnapKit
import RxSwift

final class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    let thumbnail = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let contentTitle = UILabel()
    
    let downloadButton = {
        let btn = UIButton()
        btn.setTitle("받기", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.cornerRadius = 15
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .systemGray5
        return btn
    }()
    let companyLabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let genreLabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let gradeLabel = {
        let label = UIButton()
        label.setImage(UIImage(systemName: "star.fill"), for: .normal)
        label.setTitleColor(.lightGray, for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 12)
        return label
    }()

    let firstPreview = UIImageView()
      
    let secondPreview = UIImageView()
      
    let thirdPreview = UIImageView()
    
    var disposeBag = DisposeBag()
    
    private let viewModel = SearchTableViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
        configureStackView()
        bind()
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        downloadButton.setTitle("받기", for: .normal)
    }
    
    func bind() {
        
        let input = SearchTableViewModel.Input(downButtonTap: downloadButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.text
            .bind(with: self) { owner, value in
                owner.downloadButton.setTitle(value, for: .normal)
            }
            .disposed(by: disposeBag)
        
    }
    
    func configureLayout() {
        contentView.addSubview(thumbnail)
        contentView.addSubview(downloadButton)
        contentView.addSubview(contentTitle)
        contentView.addSubview(companyLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(gradeLabel)
        
        thumbnail.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(50)
        }
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(thumbnail.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        contentTitle.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail.snp.trailing).offset(20)
            make.centerY.equalTo(thumbnail.safeAreaLayoutGuide)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-20)
        }
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(5)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(5)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(20)
        }
        gradeLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(5)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(20)
        }
    }
 
    private func configureStackView() {
         
       let stackView = UIStackView(arrangedSubviews: [firstPreview, secondPreview, thirdPreview])
       stackView.axis = .horizontal
       stackView.distribution = .fillEqually
       stackView.spacing = 5
       stackView.layer.cornerRadius = 10
       stackView.layer.masksToBounds = true
         
       contentView.addSubview(stackView)
       
        stackView.snp.makeConstraints { make in
            make.top.equalTo(companyLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
    }

}
