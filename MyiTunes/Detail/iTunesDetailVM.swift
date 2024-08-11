//
//  iTunesDetailVM.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class iTunesDetailVM: BaseVM {
    
    let item: AppResult
 
    struct Output {
        let appImage: Observable<URL>
        let appName: Observable<String>
        let artistName: Observable<String>
        let version: Observable<String>
        let releaseNotes: Observable<String>
        let screenshotUrls: Observable<[ScreenshotSectionModel]>
        let description: Observable<String>
    }
    
    init(item: AppResult){
        self.item = item
    }
    
    func transform() -> Output {
        let appImage = Observable.just(item.artworkUrl100)
                                    .compactMap { URL(string: $0) }
        
        let appName = Observable.just(item.trackName)
        
        let artistName = Observable.just(item.artistName)
        
        let version = Observable.just("버전 \(item.version)")
        
        let releaseNotes = Observable.just(item.releaseNotes)
        
        let screenshotUrls = Observable.just(item.screenshotUrls)
            .map{ $0.compactMap{ URL(string: $0) } }
            .map{ [ScreenshotSectionModel(items: $0)] }
        
        let description = Observable.just(item.description)
        
        return Output(appImage: appImage, appName: appName, artistName: artistName, version: version, releaseNotes: releaseNotes, screenshotUrls: screenshotUrls, description: description)
    }
}
