//
//  Similar.swift
//  movcha
//
//  Created by junehee on 6/24/24.
//

import Foundation

// 영화+드라마 통합
struct Similar: Decodable {
    let results: [SimilarResults]
}

struct SimilarResults: Decodable {
    let poster_path: String
}



// 비슷한 콘텐츠 (영화)
struct MovieSimilar: Decodable {
    let page: Int
    var results: [MovieSimilarResults]
    let total_pages: Int
    let total_results: Int
}

struct MovieSimilarResults: Decodable {
    let original_title: String
    let title: String
    let id: Int
    let poster_path: String?
}

// 비슷한 콘텐츠 (TV)
struct TVSimilar: Decodable {
    let page: Int
    var results: [TVSimilarResults]
    let total_pages: Int
    let total_results: Int
}

struct TVSimilarResults: Decodable {
    let original_name: String
    let name: String
    let id: Int
    let poster_path: String?
}
