//
//  APIService.swift
//  MyiTunes
//
//  Created by 장예지 on 8/9/24.
//

import Foundation
import Alamofire
import RxSwift

enum NetworkResult<T> {
    case success(T)
    case error(NetworkError)
}

enum NetworkError: Error {
    case badRequest
    case forbidden
    case notfound
    case internalServerError
    case unknownNetworkError
}

final class APIService {
    
    static var shared = APIService()
    
    private init(){}
    
    func networking<T: Decodable>(api: APIManager, of: T.Type) -> Single<NetworkResult<T>> {
        return Single.create { single -> Disposable in
            AF.request(api.url,
                       method: api.method,
                       parameters: api.parameters,
                       encoding: URLEncoding.queryString).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    guard let statusCode = response.response?.statusCode else {
                        single(.success(.error(.unknownNetworkError)))
                        return
                    }
                    
                    switch statusCode {
                    case 200...299:
                        single(.success(.success(result)))
                    case 400:
                        single(.success(.error(.notfound)))
                    case 403:
                        single(.success(.error(.forbidden)))
                    case 404:
                        single(.success(.error(.notfound)))
                    case 500:
                        single(.success(.error(.internalServerError)))
                    default:
                        single(.success(.error(.unknownNetworkError)))
                    }
                    
                case .failure(_):
                    print("error")
                }
            }
            
            return Disposables.create()
        }
        .debug("API 통신")
    }
}
