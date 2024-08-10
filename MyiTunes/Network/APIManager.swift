//
//  APIManager.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import Foundation
import Alamofire

enum APIManager {
    case search(term: String)
}

extension APIManager {
    var baseURL: String {
        return "https://itunes.apple.com/"
    }
    
    var url: String {
        return baseURL + path
    }
    
    var path: String {
        return "search"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let term):
            return [
                "term" : term,
                "country" : "KR",
                "media" : "software",
                "limit": 10
            ]
        }
    }
}
