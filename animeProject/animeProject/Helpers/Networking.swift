//
//  Networking.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/30/21.
//

import Foundation


class Networking {
    func fetchShows(search: String, completion: @escaping ([Show]) -> Void) {
        guard let url = URL(string: "https://api.jikan.moe/v3/search/anime?q=\(search)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, r, e in
            
            guard let data = data else { return }
            
            if let decoded = try? JSONDecoder().decode(Shows.self, from: data) {
                completion(decoded.results)
            }
        }.resume()
        
    }
    func fetchCharacters(search: String, completion: @escaping ([Character]) -> Void) {
        guard let url = URL(string: "https://api.jikan.moe/v3/search/character?q=\(search)") else { return }
        URLSession.shared.dataTask(with: url) { data, r, e in
            
            guard let data = data else { return }
            
            if let decoded = try? JSONDecoder().decode(Characters.self, from: data) {
                completion(decoded.results)
            }
        }.resume()
    }
}
