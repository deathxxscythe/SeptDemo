//
//  Networking.swift
//  queryStrings
//
//  Created by Nathaniel Patterson on 10/28/21.
//

import Foundation

class Networking {
    func createRequest(baseURL: String, queryKey: String, queryValue: String) -> URLRequest {
        guard let url = URL(string: baseURL) else {
            fatalError("url is required")
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = URLQueryItem(name: queryKey, value: queryValue)
        components?.queryItems = [queryItems]
        guard let finalURl = components?.url else  {
            fatalError("URL optional is nil")
        }
        let request = URLRequest(url: finalURl)
        return request
    }
    
    func fetch(url: URLRequest, completion: @escaping (Drinks) -> Void) {
        var request = url
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            guard let response: Drinks = try? JSONDecoder().decode(Drinks.self, from: data) else {
                return
            }
            completion(response)
        }.resume()
    }
}
