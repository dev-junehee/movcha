//
//  TMDBAPI.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import Foundation
import Alamofire

enum GenreType: String {
    case movie = "movie"
    case tv = "tv"
}

enum SearchType: String {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}

enum TmdbAPI {
    case trending
    case genre(type: GenreType)
    case search(type: SearchType, query: String)
    case credits(type: GenreType, id: Int)
    case similar(type: GenreType, id: Int)
    case recommend(type: GenreType, id: Int)
    case image
    
    var headers: HTTPHeaders {
        return [
            "Authorization": API.KEY.tmdb,
            "accept": "application/json"
        ]
    }
    
    var baseURL: String {
        return API.URL.TMDB.base
    }
    
    var endPoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + API.URL.TMDB.Trending.all)!
        case .genre(let type):
            return URL(string: baseURL + "genre/\(type.rawValue)/list")!
        case .search(let type, _):
            return URL(string: baseURL + "search/\(type.rawValue)")!
        case .credits(let type, let id):
            return URL(string: baseURL + "\(type.rawValue)/\(id)/credits")!
        case .similar(let type, let id):
            return URL(string: baseURL + "\(type.rawValue)/\(id)/similar")!
        case .recommend(let type, let id):
            return URL(string: baseURL + "\(type.rawValue)/\(id)/recommendations")!
        case .image:
            return URL(string: API.URL.TMDB.img)!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: Parameters {
        switch self {
        case .trending, .genre, .credits, .similar, .recommend:
            return ["language": "ko-KR"]
        case .search(_, let query):
            return [
                "language": "ko-KR",
                "include_adult": false,
                "query": query
            ]
        case .image:
            return ["": ""]
        }
    }
    
}
