//
//  JokesViewModel.swift
//  week03assessment
//
//  Created by Nathaniel Patterson on 10/18/21.
//

import Foundation


struct JokesResponse:Decodable {
    var setup: String
    var delivery: String
}

enum JokesViewModel {
    static func fetch(_ completion: @escaping (JokesResponse) -> Void){
        if let url = URL(string: "https://v2.jokeapi.dev/joke/Any?type=twopart") {
            let request = URLRequest(url:url)
            
            URLSession.shared.dataTask(with: request) { data, _, response in
                guard let data = data else {
                    return
                }

                guard let response: JokesResponse = try? JSONDecoder().decode(JokesResponse.self, from: data) else {
                    return
                }
                print(response)
                completion(response)
            }.resume()
        }
    }
}
