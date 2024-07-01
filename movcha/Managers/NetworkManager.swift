//
//  NetworkManager.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let headers: HTTPHeaders = [
        "Authorization": API.KEY.tmdb,
        "accept": "application/json"
    ]
    
    func callRequest<T: Decodable>(api: TmdbAPI, completionHandler: @escaping (T?, String?) -> Void) {
        print(api)
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.params,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.headers
        ).responseDecodable(of: T.self) { res in
            switch res.result {
            case .success(let value):
                print("callRequest 성공", T.self)
                dump(value)
                completionHandler(value, nil)
            case .failure(let error):
                print("callRequest 실패", T.self)
                dump(error)
                completionHandler(nil, error.errorDescription?.debugDescription)
            }
        }
    }

}
