//
//  DrinksViewModel.swift
//  week03assessment
//
//  Created by Nathaniel Patterson on 10/18/21.
//

import Foundation

struct DrinksResponse:Decodable {
    var drinks: [DrinkData]
}

struct DrinkData:Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
}

enum DrinksViewModel {
    static func fetch(_ completion: @escaping (DrinksResponse) -> Void){
        if let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Rum") {
            let request = URLRequest(url:url)
            
            URLSession.shared.dataTask(with: request) { data, _, response in
                guard let data = data else {
                    return
                }

                guard let response: DrinksResponse = try? JSONDecoder().decode(DrinksResponse.self, from: data) else {
                    return
                }
                print(response)
                completion(response)
            }.resume()
        }
    }
}
