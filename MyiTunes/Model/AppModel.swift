//
//  AppModel.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import Foundation

struct AppList: Decodable {
    let resultCount: Int
    let results: [AppResult]
}

struct AppResult: Decodable {
    let trackName: String
    //개발자
    let artistName: String
    //제공자
    let sellerName: String
    let artworkUrl60: String
    let artworkUrl100: String
    let screenshotUrls: [String]
    let version: String
    //평점
    let averageUserRatingForCurrentVersion: Double
    //콘텐츠 등급
    let trackContentRating: String
    let releaseNotes: String
    let description: String
    let genres: [String]
    
    var formattedRating: String {
        return String(format: "%.1f", averageUserRatingForCurrentVersion)
    }
}
