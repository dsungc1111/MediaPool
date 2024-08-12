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
        let downloadedApp = realmManager.fetchDownloadedApp()
        
        output.detailInfo
            .subscribe(with: self) { owner, result in

                let image = URL(string: result.artworkUrl100)
                owner.detailView.appLogoView.kf.setImage(with: image)
                owner.detailView.appTitleLabel.text = result.trackName
                owner.detailView.nameTitle.text = result.artistName
                owner.detailView.releaseLabel.text = result.releaseNotes
                owner.detailView.descriptionLabel.text = result.description
                
                for app in downloadedApp {
                    if app.trackId == result.trackId {
                        owner.detailView.downloadButton.setTitle("열기", for: .normal)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        output.screenShot
            .bind(to: detailView.collectionView.rx.items(cellIdentifier: DetailImageCollectionViewCell.identifier, cellType: DetailImageCollectionViewCell.self)) { (item, element, cell) in
                let imageUrl = URL(string: element)
                cell.imageView.kf.setImage(with: imageUrl)
                
                
                
                
            }
            .disposed(by: disposeBag)
        
    }
 

}
