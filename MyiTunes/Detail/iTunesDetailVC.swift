//
//  iTunesDetailVC.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import UIKit
import SnapKit
import RxSwift

final class iTunesDetailVC: BaseVC {
    
    private let scrollView = {
        let object = UIScrollView()
        object.showsHorizontalScrollIndicator = false
        return object
    }()
    
    private let contentView = UIView()
    
    private lazy var appBackView = {
        let object = UIView()
        [appImageView, appInfoStackView].map { object.addSubview($0) }
        return object
    }()
    
    private lazy var appInfoStackView = {
        let object = UIStackView()
        object.axis = .vertical
        object.spacing = 12
        [appTitleLabel, providerLabel, downloadButton].map { object.addArrangedSubview($0)}
        return object
    }()
    
    private let appImageView = {
        let object = UIImageView()
        object.backgroundColor = .gray
        object.contentMode = .scaleAspectFill
        object.clipsToBounds = true
        object.layer.cornerRadius = 8
        return object
    }()
    
    private let appTitleLabel = {
        let object = UILabel()
        object.text = "카카오맵"
        object.font = .boldSystemFont(ofSize: 20)
        return object
    }()
    
    private let providerLabel = {
        let object = UILabel()
        object.text = "Kakao Corp."
        object.textColor = .lightGray
        return object
    }()
    
    private let downloadButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.attributedTitle = AttributedString("받기", attributes: AttributeContainer([.foregroundColor: UIColor.white]))
        config.background.backgroundColor = .systemBlue
        
        let object = UIButton()
        object.configuration = config
        return object
    }()
    
    private lazy var releaseNoteBackView = {
        let object = UIView()
        [releaseNotesTextLabel, versionTextLabel, releaseNotesTextView].map { object.addSubview($0) }
        return object
    }()
    
    private let releaseNotesTextLabel = {
        let object = UILabel()
        object.text = "새로운 소식"
        object.font = .boldSystemFont(ofSize: 20)
        return object
    }()
    
    private let versionTextLabel = {
        let object = UILabel()
        object.textColor = .lightGray
        object.font = .systemFont(ofSize: 14)
        object.text = "버전 5.13.0"
        return object
    }()
    
    private let releaseNotesTextView = {
        let object = UILabel()
        object.numberOfLines = 0
        object.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        object.font = .systemFont(ofSize: 12)
        return object
    }()
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let object = UICollectionView(frame: .zero, collectionViewLayout: layout)
        object.register(AppScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: AppScreenShotCollectionViewCell.identifier)
        object.delegate = self
        object.dataSource = self
        return object
    }()
    
    private let descriptionTextView = {
        let object = UILabel()
        object.numberOfLines = 0
        object.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        object.font = .systemFont(ofSize: 12)
        return object
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(appBackView)
        contentView.addSubview(releaseNoteBackView)
        contentView.addSubview(collectionView)
        contentView.addSubview(descriptionTextView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        //appInfoBackView
        appBackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(scrollView)
            make.height.equalTo(140)
        }
        
        
        appImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.width.equalTo(appImageView.snp.height)
        }
        
        appInfoStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(appImageView)
            make.leading.equalTo(appImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
        }
        
        //relaseNoteBackView
        releaseNoteBackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(appBackView.snp.bottom).offset(20)
        }
        
        releaseNotesTextLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        versionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseNotesTextLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
        }
        
        releaseNotesTextView.snp.makeConstraints { make in
            make.top.equalTo(versionTextLabel.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        //screenshot
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseNoteBackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(400)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension iTunesDetailVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppScreenShotCollectionViewCell.identifier, for: indexPath) as! AppScreenShotCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: collectionView.frame.height)
    }
}
