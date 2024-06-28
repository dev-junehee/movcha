//
//  Credit.swift
//  movcha
//
//  Created by junehee on 6/10/24.
//

struct Credits: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let original_name: String
    let character: String
    let profile_path: String?
    let order: Int
}
