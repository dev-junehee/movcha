//
//  Search.swift
//  movcha
//
//  Created by junehee on 6/12/24.
//

import Foundation

struct Search: Decodable {
    let page: Int
    var results: [SearchResults]
    let total_pages: Int
    let total_results: Int
}

struct SearchResults: Decodable {
    let original_name: String?
    let original_title: String?
    let name: String?
    let title: String?
    let id: Int
    let backdrop_path: String?
    let poster_path: String?
    let profile_path: String?
}


// 영화
struct MovieSearch: Decodable {
    let page: Int
    var results: [MovieResults]
    let total_pages: Int
    let total_results: Int
}

struct MovieResults: Decodable {
    let backdrop_path: String
    let poster_path: String
}

// 드라마
struct TVSearch: Decodable {
    let page: Int
    var results: [TVResults]
    let total_pages: Int
    let total_results: Int
}

struct TVResults: Decodable {
    let backdrop_path: String?
    let poster_path: String?
//    let adult: Bool
//    let genre_ids: [Int]
//    let id: Int
//    let origin_country: [String]
//    let origin_language: String?
//    let origin_name: String?
//    let name: String
//    let overview: String
//    let first_air_date: String
//    let popularity: Double
//    let vote_average: Double
//    let vote_count: Int
}


// 영화인
struct PersonSearch: Decodable {
    let page: Int
    var results: [PersonResults]
    let total_pages: Int
    let total_results: Int
}

struct PersonResults: Decodable {
    let name: String
    let original_name: String
    let profile_path: String
}
