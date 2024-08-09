//
//  iTunesCollectionViewCell.swift
//  MyiTunes
//
//  Created by 장예지 on 8/8/24.
//

import UIKit
import SnapKit

final class iTunesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: iTunesCollectionViewCell.self)
    
    let appImageView = {
        let object = UIImageView()
        object.backgroundColor = .systemGray6
        object.layer.cornerRadius = 8
        object.contentMode = .scaleAspectFill
        return object
    }()
    
    let appTitleLabel = {
        let object = UILabel()
        object.text = "어쩌구저쩌구구구"
        object.font = .boldSystemFont(ofSize: 16)
        return object
    }()
    
    let downloadButton = {
        var configure = UIButton.Configuration.filled()
        configure.cornerStyle = .capsule
        configure.background.backgroundColor = .lightGray
        configure.attributedTitle = AttributedString("받기", attributes: AttributeContainer([.foregroundColor: UIColor.systemBlue]))
        return UIButton(configuration: configure)
    }()
    
    let starImageView = {
        let object = UIImageView()
        object.contentMode = .scaleAspectFit
        object.image = UIImage(systemName: "star.fill")
        return object
    }()
    
    let ratingLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 12)
        object.textColor = .lightGray
        object.text = "8.8"
        object.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return object
    }()
    
    let providerLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 12)
        object.textColor = .lightGray
        object.textAlignment = .center
        object.text = "Kakao Mobility App"
        return object
    }()
    
    let categoryLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 12)
        object.textColor = .lightGray
        object.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        object.text = "내비게이션"
        return object
    }()
    
    let firstAppDetailImageView = {
        let object = UIImageView()
        object.backgroundColor = .systemGray6
        object.layer.cornerRadius = 8
        return object
    }()
    
    let secondAppDetailImageView = {
        let object = UIImageView()
        object.backgroundColor = .systemGray5
        object.layer.cornerRadius = 8
        return object
    }()
    
    let thirdAppDetailImageView = {
        let object = UIImageView()
        object.backgroundColor = .systemGray4
        object.layer.cornerRadius = 8
        return object
    }()
    
    lazy var appInfoStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        [appImageView, appTitleLabel, downloadButton].map { stackView.addArrangedSubview($0)}
        return stackView
    }()
    
    lazy var appDetailInfoStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        [starImageView, ratingLabel, providerLabel, categoryLabel].map { stackView.addArrangedSubview($0)}
        return stackView
    }()
    
    lazy var appImageStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        detailImageViews.map { stackView.addArrangedSubview($0)}
        return stackView
    }()
    
    lazy var containerStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        [appInfoStackView, appDetailInfoStackView, appImageStackView].map{ stackView.addArrangedSubview($0)}
        return stackView
    }()
    
    lazy var detailImageViews = [firstAppDetailImageView, secondAppDetailImageView, thirdAppDetailImageView]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy(){
        contentView.addSubview(containerStackView)
    }
    
    private func configureLayout(){
        appInfoStackView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(12)
        }
        
        appImageView.snp.makeConstraints { make in
            make.width.equalTo(appImageView.snp.height)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        
        starImageView.snp.makeConstraints { make in
            make.size.equalTo(14)
        }
    }
}
