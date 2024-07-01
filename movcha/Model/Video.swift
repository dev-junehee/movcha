//
//  Video.swift
//  movcha
//
//  Created by junehee on 7/2/24.
//

import Foundation

struct Video: Decodable {
    let id: Int?
    let results: [VideoResults]?
}

struct VideoResults: Decodable {
    let name: String
    let key: String
}
