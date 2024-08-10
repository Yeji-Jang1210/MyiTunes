//
//  iTunesCollectionViewCell.swift
//  MyiTunes
//
//  Created by 장예지 on 8/8/24.
//

import UIKit
import RxSwift
import Kingfisher
import SnapKit

final class iTunesCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = String(describing: iTunesCollectionViewCell.self)
    
    let cellView = iTunesCollectionViewCellView()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(12)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func bind(viewModel: iTunesCollectionViewCellVM) {
        let input = iTunesCollectionViewCellVM.Input()
        let output = viewModel.transform(input: input)
        
        output.appDetailImages
            .asDriver(onErrorJustReturn: [])
            .drive(with: self){ owner, urls in
                for (index, imageView) in owner.cellView.detailImageViews.enumerated() {
                    imageView.kf.setImage(with: urls[index])
                }
            }
            .disposed(by: disposeBag)
        
        output.appImage
            .bind(with: self){ owner, url in
                owner.cellView.appImageView.kf.setImage(with: url)
            }
            .disposed(by: disposeBag)
        
        output.title
            .bind(to: cellView.appTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.rating
            .bind(to: cellView.ratingLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.artistName
            .bind(to: cellView.providerLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.genre
            .bind(to: cellView.categoryLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}
