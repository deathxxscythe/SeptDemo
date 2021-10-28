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
/*
{
    "strDrink": "155 Belmont",
    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/yqvvqs1475667388.jpg",
    "idDrink": "15346"
}
 */
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
