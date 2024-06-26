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
    case trendingMovie
    case trendingTV
    case genre(type: GenreType)
    case search(type: SearchType, query: String)
    case credits(type: GenreType, id: Int)
    case similar(type: GenreType, id: Int)
    case recommend(type: GenreType, id: Int)
    case topRatedMovie
    case topRatedTV
    case popularMovie
    case popularTV
    case videos(type: GenreType, id: Int)
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
        case .trendingMovie:
            return URL(string: baseURL + API.URL.TMDB.Trending.movie)!
        case .trendingTV:
            return URL(string: baseURL + API.URL.TMDB.Trending.tv)!
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
        case .topRatedMovie:
            return URL(string: baseURL + API.URL.TMDB.TopRated.movie)!
        case .topRatedTV:
            return URL(string: baseURL + API.URL.TMDB.TopRated.tv)!
        case .popularMovie:
            return URL(string: baseURL + API.URL.TMDB.Popular.movie)!
        case .popularTV:
            return URL(string: baseURL + API.URL.TMDB.Popular.tv)!
        case .videos(let type, let  id):
            return URL(string: baseURL + "\(type.rawValue)/\(id)/" + API.URL.TMDB.Videos.videos)!
        case .image:
            return URL(string: API.URL.TMDB.img)!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: Parameters {
        switch self {
        case .trending, .trendingMovie, .trendingTV, .genre, .credits, .similar, .recommend, .videos:
            return ["language": "ko-KR"]
        case .topRatedMovie, .topRatedTV, .popularMovie:
            return [
                "language": "ko-KR",
                "page": 1,
                "region": "410"
            ]
        case .popularTV:
            return [
                "language": "ko-KR",
                "page": 1,
            ]
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
