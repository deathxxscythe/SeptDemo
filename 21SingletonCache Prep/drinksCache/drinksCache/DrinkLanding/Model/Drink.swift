//
//  Drink.swift
//  drinksCache
//
//  Created by Luat on 8/23/21.
//

import Foundation

struct DrinkModel: Codable {
    let drinks: [DrinkItem]
}

struct DrinkItem: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case imageStr = "strDrinkThumb"
        case idDrink
    }
    
    let name: String
    let imageStr: String
    let idDrink: String
}
