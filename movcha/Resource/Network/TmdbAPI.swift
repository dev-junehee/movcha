//
//  TMDBAPI.swift
//  movcha
//
//  Created by junehee on 6/26/24.
//

import Foundation
import Alamofire
import Moya

enum GenreType: String {
    case movie = "movie"
    case tv = "tv"
}

enum SearchType: String {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}

enum TmdbAPI: TargetType {
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
    
    var baseURL: URL {
        return URL(string: API.URL.TMDB.base)!
    }
    
    var path: String {
        switch self {
        case .trending:
            return API.URL.TMDB.Trending.all
        case .trendingMovie:
            return API.URL.TMDB.Trending.movie
        case .trendingTV:
            return API.URL.TMDB.Trending.tv
        case .genre(let type):
            return "genre/\(type.rawValue)/list"
        case .search(let type, _):
            return "search/\(type.rawValue)"
        case .credits(let type, let id):
            return "\(type.rawValue)/\(id)/credits"
        case .similar(let type, let id):
            return "\(type.rawValue)/\(id)/similar"
        case .recommend(let type, let id):
            return "\(type.rawValue)/\(id)/recommendations"
        case .topRatedMovie:
            return API.URL.TMDB.TopRated.movie
        case .topRatedTV:
            return API.URL.TMDB.TopRated.tv
        case .popularMovie:
            return API.URL.TMDB.Popular.movie
        case .popularTV:
            return API.URL.TMDB.Popular.tv
        case .videos(let type, let  id):
            return "\(type.rawValue)/\(id)/" + API.URL.TMDB.Videos.videos
        case .image:
            return API.URL.TMDB.img
        }
    }
    
    var headers: [String : String]? {
        return [
            "Authorization": API.KEY.tmdb,
            "accept": "application/json"
        ]
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .trending, .trendingMovie, .trendingTV, .genre, .credits, .similar, .recommend, .videos: break
            // return ["language": "ko-KR"]
        case .topRatedMovie, .topRatedTV, .popularMovie: break
            // return [
            //     "language": "ko-KR",
            //     "page": 1,
            //     "region": "410"
            // ]
        case .popularTV: break
            // return [
            //     "language": "ko-KR",
            //     "page": 1,
            // ]
        case .search(_, let query): break
            // return [
            //     "language": "ko-KR",
            //     "include_adult": false,
            //     "query": query
            // ]
        case .image: break
            // return ["": ""]
        }
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
