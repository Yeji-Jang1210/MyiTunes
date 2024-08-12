//
//  SearchiTunesVM.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchiTunesVM: BaseVM, BaseVMIO {
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let lists: PublishSubject<[SearchiTunesSectionModel]>
    }
    
    func transform(input: Input) -> Output {
        let lists = PublishSubject<[SearchiTunesSectionModel]>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap {
                APIService.shared.networking(api: .search(term: $0), of: AppList.self)
            }
            .subscribe(with: self){ owner, response in
                switch response {
                case .success(let result):
                    let vms = result.results.map { iTunesCollectionViewCellVM($0)}
                    lists.onNext([SearchiTunesSectionModel(items: vms)])
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
            
        return Output(lists: lists)
    }
}
