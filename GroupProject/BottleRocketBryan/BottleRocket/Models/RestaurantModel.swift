//
//  RestaurantModel.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/20/21.
//

import Foundation

struct RestaurantResult: Decodable {
    var restaurants: [Restaurant]
}

struct Restaurant: Decodable {
    let name: String?
    let backgroundImageURL: String?
    let category: String?
    let contact: Contact?
    let location: Location?
}

struct Contact: Decodable {
    let formattedPhone: String?
    let twitter: String?
}


struct Location: Decodable {
    let address: String?
    let city: String?
    let state: String?
    let postalCode: String?
    let lat: Double?
    let lng: Double?
}
