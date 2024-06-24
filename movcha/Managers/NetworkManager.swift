//
//  NetworkManager.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import Alamofire

enum NetworkType: String {
    case movie = "movie"
    case tv = "tv"
    case person
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let headers: HTTPHeaders = [
        "Authorization": API.KEY.kmdb,
        "accept": "application/json"
    ]
    
    
    // 비슷한 콘텐츠 - 영화
    func getSimilarMovieContents(
                            id: Int
    ) {
        let URL = "\(API.URL.KMDB.Similar.movie)\(id)/similar?language=ko"
     
        AF.request(URL, headers: headers)
            .responseDecodable(of: MovieSimilar.self) { res in
                switch res.result {
                case .success(let value):
                    print("비슷한 콘텐츠 성공", value)
                case .failure(let error):
                    print("비슷한 콘텐츠 에러", error)
                }
            }
        }
    
    // 비슷한 콘텐츠 - TV
    func getSimilarTVContents(
                            id: Int,
                            completionHandler: @escaping (TVSimilar) -> Void
    ) {
        let URL = "\(API.URL.KMDB.Similar.tv)\(id)/similar?language=ko"
        
        AF.request(URL, headers: headers)
            .responseDecodable(of: TVSimilar.self) { res in
                switch res.result {
                case .success(let value):
                    print("비슷한 콘텐츠 성공")
                    completionHandler(value)
                case .failure(let error):
                    print("비슷한 콘텐츠 에러", error)
                }
            }
        }
        
    // 추천 콘텐츠
    func getRecommendContents(id: Int) {
        
    }
    
}
