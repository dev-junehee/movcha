//
//  Search.swift
//  movcha
//
//  Created by junehee on 6/12/24.
//

import Foundation

struct TVSearch: Decodable {
    let page: Int
    var results: [TVResults]
    let total_pages: Int
    let total_results: Int
}

struct TVResults: Decodable {
    let backdrop_path: String
    let poster_path: String
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
