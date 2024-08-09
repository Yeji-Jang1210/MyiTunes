//
//  iTunesCollectionViewCellVM.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class iTunesCollectionViewCellVM: BaseVM {
    let app: AppResult
    
    struct Input {
        
    }
    
    struct Output {
        let appImage: Observable<URL>
        let appDetailImages: Observable<[URL]>
        let title: Observable<String>
        let rating: Observable<String>
        let artistName: Observable<String>
        let genre: Observable<String>
    }
    
    init(_ app: AppResult){
        self.app = app
    }
    
    func transform(input: Input) -> Output {
        
        let appImage = Observable.just(app.artworkUrl100)
            .compactMap { URL(string: $0) }
        
        let appDetailImages = Observable.just(app.screenshotUrls)
            .map { Array($0[0...2]) }
            .map { $0.compactMap { URL(string: $0)} }
            
        let title = Observable.just(app.trackName)
        
        let rating = Observable.just(app.formattedRating)
        
        let artistName = Observable.just(app.artistName)
        
        let genre = Observable.from(optional: app.genres.first)
        
        return Output(appImage: appImage,
                      appDetailImages: appDetailImages,
                      title: title,
                      rating: rating,
                      artistName: artistName,
                      genre: genre)
    }
}
