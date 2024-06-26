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
    
    func callRequest<T: Decodable>(api: TmdbAPI, completionHandler: @escaping (T?, AFError?) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.params,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.headers
        ).responseDecodable(of: T.self) { res in
            switch res.result {
            case .success(let value):
                print("getSearch 검색 성공")
                dump(value)
                completionHandler(value, nil)
            case .failure(let error):
                print("getSearch 검색 실패")
                dump(error)
                completionHandler(nil, error)
            }
        }
    }
    
    
//    // 검색
//    func getSearchContents(type: Int, query: String, completionHandler: @escaping ([SearchResults]) -> Void) {
//        var URL = ""
//        
//        switch type {
//        case 0:
//            URL = "\(API.URL.TMDB.Search.movie)\(query)"
//            break
//        case 1:
//            URL = "\(API.URL.TMDB.Search.tv)\(query)"
//            break
//        case 2:
//            URL = "\(API.URL.TMDB.Search.person)\(query)"
//            break
//        default:
//            print("검색 카테고리 선택 오류")
//        }
//        
//        print("API URL 확인", URL)
//        AF.request(URL, headers: headers)
//            .responseDecodable(of: Search.self) { res in
//                switch res.result {
//                case .success(let value):
//                    print("검색 성공")
//                    print(value.results)
//                    completionHandler(value.results)
//                case .failure(let error):
//                    print("검색 실패")
//                    print(error)
//                }
//            }
//    }
    
    
    // 비슷한 콘텐츠
    func getSimilarContentstype(type: Int,
                                id: Int, 
                                completionHandler: @escaping ([SimilarRecommendResults]) -> Void
    ) {
        let MOVIE_URL = "\(API.URL.TMDB.Similar.movie)\(id)/similar?language=ko"
        let TV_URL = "\(API.URL.TMDB.Similar.tv)\(id)/similar?language=ko"
        
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
        let MOVIE_URL = "\(API.URL.TMDB.Recommend.movie)\(id)/recommendations?language=ko"
        let TV_URL = "\(API.URL.TMDB.Recommend.tv)\(id)/recommendations?language=ko"
        
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
