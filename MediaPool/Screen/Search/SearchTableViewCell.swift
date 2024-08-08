//
//  SearchTableViewCell.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit
import SnapKit


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
        btn.layer.cornerRadius = 10
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .lightGray
        return btn
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        contentView.addSubview(thumbnail)
        contentView.addSubview(downloadButton)
        contentView.addSubview(contentTitle)
        
        
        thumbnail.snp.makeConstraints { make in
            make.leading.centerY.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(50)
        }
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(60)
        }
        contentTitle.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail.snp.trailing).offset(20)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-20)
        }
                
       
        
    }

}
