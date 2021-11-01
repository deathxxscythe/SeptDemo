//
//  Model.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/30/21.
//

import Foundation


struct Shows: Decodable {
    let results: [Show]
}

struct Show: Decodable {
    let title: String
    let synopsis: String?
    let url: String?
    let image_url: String
    let episodes: Int
    let score: Double
    let members: Int
    let rated: String?
}

struct Characters: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let image_url: String
    let url: String?
}
