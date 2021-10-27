//
//  Network.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/20/21.
//

import UIKit

protocol NetworkServiceProcotol {
    func fetchRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void)
    func fetchImage(imageStr: String, completion: @escaping (UIImage?) -> Void)
}

class NetworkService: NetworkServiceProcotol {
    
    typealias RestaurantCompletion = (Result<[Restaurant], Error>) -> Void
    typealias ImageCompletion = (UIImage?) -> Void
    
    let restaurantStr = NetworkConstants.restaurantAddress
    
    func fetchRestaurants(completion: @escaping RestaurantCompletion) {
        if let url = URL(string: restaurantStr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let results = try decoder.decode(RestaurantResult.self, from: data)
                        completion(.success(results.restaurants))
                        for restaurant in results.restaurants {
                            if let imageStr = restaurant.backgroundImageURL {
                                self.fetchImage(imageStr: imageStr, completion: {_ in})
                            }
                        }
                    } catch {
                        completion(.failure(RestaurantError.decodingError))
                    }
                } else {
                    completion(.failure(RestaurantError.noData))
                }
            }.resume()
        } else {
            completion(.failure(RestaurantError.invalidURL))
        }
    }
    
    func fetchImage(imageStr: String, completion: @escaping ImageCompletion) {
        let finalImageStr = imageStr.replacingOccurrences(of: "http", with: "https")
        if let image = ImageCache.shared.read(imageStr: finalImageStr) {
            completion(image)
            print("caching \(finalImageStr.dropFirst(73))")
        } else {
            completion(nil)
            print("fetching \(finalImageStr.dropFirst(73))")
            if let imageURL = URL(string: finalImageStr) {
                URLSession.shared.dataTask(with: imageURL) { data, r, e in
                    guard let data = data else {
                        
                        return
                        
                    }
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            ImageCache.shared.write(imageStr: finalImageStr, image: image)
                            completion(image) 
                        }
                    }
                }.resume()
            }
        }
    }
    
}

enum RestaurantError : Error {
    case noData
    case decodingError
    case invalidURL
}
