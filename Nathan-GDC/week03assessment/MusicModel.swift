//
//  MusicModel.swift
//  week03assessment
//
//  Created by Nathaniel Patterson on 10/27/21.
//

import Foundation

struct MusicResponse: Decodable {
//    let results: [songs]
    let feed: SecondLevel
}
struct SecondLevel:Decodable {
    let results: [songs]
}
struct songs: Decodable {
    let artistName: String
    let name: String
}
