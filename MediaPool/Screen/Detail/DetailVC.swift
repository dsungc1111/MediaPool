//
//  DetailVC.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class DetailVC: BaseVC {

    private let detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
 
    
    let viewModel = DetailViewModel()
    
    private let disposeBag = DisposeBag()
    private let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    override func bind() {
        
        let output = viewModel.initialSetting()
        
        output.detailInfo
            .subscribe(with: self) { owner, result in
                owner.detailView.configureUI(result: result)
            }
            .disposed(by: disposeBag)
        
        output.screenShot
            .bind(to: detailView.collectionView.rx.items(cellIdentifier: DetailImageCollectionViewCell.identifier, cellType: DetailImageCollectionViewCell.self)) { (item, element, cell) in
                cell.configureCell(element: element)
            }
            .disposed(by: disposeBag)
        
    }
 

}
