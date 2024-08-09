//
//  SearchiTunesVC.swift
//  MyiTunes
//
//  Created by 장예지 on 8/8/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class SearchiTunesVC: BaseVC {
    
    private let search = {
        let object = UISearchController(searchResultsController: nil)
        object.searchBar.placeholder = "게임, 앱, 스토리 등"
        return object
    }()
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: calculateCollectionViewCellHeight())
        
        let object = UICollectionView(frame: .zero, collectionViewLayout: layout)
        object.register(iTunesCollectionViewCell.self, forCellWithReuseIdentifier: iTunesCollectionViewCell.identifier)
        return object
    }()
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<SearchiTunesSectionModel>(
        configureCell: { dataSource, tableView, indexPath, viewModel in
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: iTunesCollectionViewCell.identifier, for: indexPath) as! iTunesCollectionViewCell
            cell.bind(viewModel: viewModel)
            return cell
    })
    
    let viewModel = SearchiTunesVM()
    
    init(title: String){
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func configureNavigationBar(){
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = search
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func bind() {
        super.bind()
        
        let input = SearchiTunesVM.Input(searchButtonTap: search.searchBar.rx.searchButtonClicked, searchText: search.searchBar.searchTextField.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.lists
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func calculateCollectionViewCellHeight() -> CGFloat {
        let screen = UIScreen.main.bounds.height
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        
        return ((screen - navigationBarHeight - tabBarHeight) / 2 ) - 20
    }
}
