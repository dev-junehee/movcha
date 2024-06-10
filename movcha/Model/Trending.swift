//
//  Trending.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//


struct Trending: Decodable {
    let page: Int
    let results: [TrendingResults]
    let total_pages: Int
    let total_results: Int
}

struct TrendingResults: Decodable {
    let id: Int
    let title: String?
    let name: String?
    let original_title: String?
    let overview: String
    let poster_path: String
    let backdrop_path: String
    let media_type: String
    let adult: Bool
    let original_language: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String?
    let video: Bool?
    let vote_average: Double
    let vote_count: Int
}

