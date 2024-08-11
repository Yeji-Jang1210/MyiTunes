//
//  iTunesDetailVC.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxDataSources

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
        object.alignment = .leading
        object.spacing = 8
        [appTitleLabel, artistNameLabel, downloadButton].map { object.addArrangedSubview($0)}
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
        object.font = .boldSystemFont(ofSize: 20)
        return object
    }()
    
    private let artistNameLabel = {
        let object = UILabel()
        object.font = .systemFont(ofSize: 12)
        object.textColor = .lightGray
        return object
    }()
    
    private let downloadButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.attributedTitle = AttributedString("받기", attributes: AttributeContainer([.foregroundColor: UIColor.white]))
        config.background.backgroundColor = .systemBlue
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20)
        
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
        return object
    }()
    
    private let releaseNotesTextView = {
        let object = UILabel()
        object.numberOfLines = 0
        object.font = .systemFont(ofSize: 12)
        return object
    }()
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 400)
        
        let object = UICollectionView(frame: .zero, collectionViewLayout: layout)
        object.register(AppScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: AppScreenShotCollectionViewCell.identifier)
        return object
    }()
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<ScreenshotSectionModel> { dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppScreenShotCollectionViewCell.identifier, for: indexPath) as! AppScreenShotCollectionViewCell
        cell.screenshotImageView.kf.setImage(with: item)
        return cell
    }
    
    private let descriptionTextView = {
        let object = UILabel()
        object.numberOfLines = 0
        object.font = .systemFont(ofSize: 12)
        return object
    }()
    
    var viewModel: iTunesDetailVM
    
    init(item: AppResult){
        viewModel = iTunesDetailVM(item: item)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            make.width.equalToSuperview().inset(20)
            make.centerX.verticalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        //appInfoBackView
        appBackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        
        appImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.width.equalTo(appImageView.snp.height)
        }
        
        appInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(appImageView).offset(8)
            make.bottom.equalTo(appImageView)
            make.leading.equalTo(appImageView.snp.trailing).offset(12)
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
    
    override func bind() {
        super.bind()
        
        let output = viewModel.transform()
        
        output.appImage
            .bind(with: self) { owner, url in
                owner.appImageView.kf.setImage(with: url)
            }
            .disposed(by: disposeBag)
        
        output.appName
            .bind(to: appTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.artistName
            .bind(to: artistNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.version
            .bind(to: versionTextLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.releaseNotes
            .bind(to: releaseNotesTextView.rx.text)
            .disposed(by: disposeBag)
        
        output.screenshotUrls
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.description
            .bind(to: descriptionTextView.rx.text)
            .disposed(by: disposeBag)
    }
    
}
