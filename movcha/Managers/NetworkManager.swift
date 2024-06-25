//
//  NetworkManager.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import Alamofire

enum NetworkType {
    case movie
    case tv
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let headers: HTTPHeaders = [
        "Authorization": API.KEY.kmdb,
        "accept": "application/json"
    ]
    
    // 비슷한 콘텐츠
    func getSimilarContentstype(type: Int,
                                id: Int, 
                                completionHandler: @escaping ([SimilarRecommendResults]) -> Void
    ) {
        let MOVIE_URL = "\(API.URL.KMDB.Similar.movie)\(id)/similar?language=ko"
        let TV_URL = "\(API.URL.KMDB.Similar.tv)\(id)/similar?language=ko"
        
        let URL = type == 0 ? MOVIE_URL : TV_URL
        
        AF.request(URL, headers: headers)
            .responseDecodable(of: SimilarRecommend.self) { res in
                switch res.result {
                case .success(let value):
                    print("비슷한 콘텐츠 성공")
                    completionHandler(value.results)
                case .failure(let error):
                    print("비슷한 콘텐츠 에러", error)
                }
            }
    }
        
    // 추천 콘텐츠
    func getRecommendContents(type: Int,
                              id: Int,
                              completionHandler: @escaping ([SimilarRecommendResults]) -> Void
    ) {
        let MOVIE_URL = "\(API.URL.KMDB.Recommend.movie)\(id)/recommendations?language=ko"
        let TV_URL = "\(API.URL.KMDB.Recommend.tv)\(id)/recommendations?language=ko"
        
        let URL = type == 0 ? MOVIE_URL : TV_URL

        AF.request(URL, headers: headers)
            .responseDecodable(of: SimilarRecommend.self) { res in
                switch res.result {
                case .success(let value):
                    print("추천작 성공")
                    dump(value)
                    completionHandler(value.results)
                case .failure(let error):
                    print("추천작 에러")
                    print(error)
                }
            }
    }
}
