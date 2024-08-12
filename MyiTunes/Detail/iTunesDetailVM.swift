//
//  iTunesDetailVM.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class iTunesDetailVM: BaseVM, BaseVMIO {
 
    struct Input {
        let item: Observable<AppResult>
    }
    
    struct Output {
        let appImage: Driver<URL?>
        let appName: Driver<String>
        let artistName: Driver<String>
        let version: Driver<String>
        let releaseNotes: Driver<String>
        let screenshotUrls: Driver<[ScreenshotSectionModel]>
        let description: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let appImage = input.item
            .map{ URL(string: $0.artworkUrl100) }
            .asDriver(onErrorJustReturn: nil)
        
        let appName = input.item
            .map { $0.trackName }
            .asDriver(onErrorJustReturn: "")
        
        let artistName = input.item
            .map{ $0.artistName }
            .asDriver(onErrorJustReturn: "")
        
        let version = input.item
            .map { "버전 \($0.version)" }
            .asDriver(onErrorJustReturn: "")
        
        let releaseNotes = input.item
            .map { $0.releaseNotes }
            .asDriver(onErrorJustReturn: "")
        
        let screenshotUrls = input.item
            .map { $0.screenshotUrls }
            .map{ $0.compactMap{ URL(string: $0) } }
            .map{ [ScreenshotSectionModel(items: $0)] }
            .asDriver(onErrorJustReturn: [])
        
        let description = input.item
            .map { $0.description }
            .asDriver(onErrorJustReturn: "")
        
        return Output(appImage: appImage, appName: appName, artistName: artistName, version: version, releaseNotes: releaseNotes, screenshotUrls: screenshotUrls, description: description)
    }
}
