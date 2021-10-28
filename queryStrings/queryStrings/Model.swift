//
//  Model.swift
//  queryStrings
//
//  Created by Nathaniel Patterson on 10/28/21.
//

import Foundation

struct Drinks: Decodable {
    let drinks: [Drink]
}

struct Drink: Decodable {
    let strDrink: String
}
