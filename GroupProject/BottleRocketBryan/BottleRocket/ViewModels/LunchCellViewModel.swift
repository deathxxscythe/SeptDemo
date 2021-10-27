//
//  LunchCellViewModel.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/21/21.
//

import UIKit

struct LunchCellViewModel {
    let restaurant: Restaurant
    let networkService = NetworkService()
    
    func fetchImage(imageStr: String, completion: @escaping (UIImage?) -> Void) {
        networkService.fetchImage(imageStr: imageStr, completion: completion)
    }
    
    var url: String {
        restaurant.backgroundImageURL ?? ""
    }
    
    var name: String {
        restaurant.name ?? ""
    }
    
    var category: String {
        restaurant.category ?? ""
    }
    
    var address: String {
        restaurant.location?.address ?? ""
    }
    
    var city: String {
        restaurant.location?.city ?? ""
    }
    
    var state: String {
        restaurant.location?.state ?? ""
    }
    
    var postal: String {
        restaurant.location?.postalCode ?? ""
    }
    
    var addressEnding: String {
        city + ", " + state + " " + postal
    }
    
    var phone: String {
        restaurant.contact?.formattedPhone ?? ""
    }
    
    var twitter: String {
        if let twitter = restaurant.contact?.twitter {
            return "@" + twitter
        } else {
            return ""
        }
    }
    
    var lat: Double {
        restaurant.location?.lat ?? 0.0
    }
    
    var long: Double {
        restaurant.location?.lng ?? 0.0
    }
}
