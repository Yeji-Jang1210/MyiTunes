//
//  BaseCollectionViewCell.swift
//  MyiTunes
//
//  Created by 장예지 on 8/10/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self) deinitialize")
    }
    
    func configureHierarchy(){}
    
    func configureLayout(){}
    
    func configureUI(){}
    
    func bind(){}
}
