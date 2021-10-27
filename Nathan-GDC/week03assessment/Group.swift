//
//  Group.swift
//  week03assessment
//
//  Created by Nathaniel Patterson on 10/27/21.
//

import Foundation
import UIKit


class APIGroup {
    let jokesAddress = "https://v2.jokeapi.dev/joke/Any?type=twopart"
    
    let drinksAddress = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Rum"
    
    let musicAddress = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/songs.json"
    
    var jokesResponse: JokesResponse?
    var drinksResponse: DrinksResponse?
    var musicResponse: MusicResponse?
    let group = DispatchGroup()
    
    func groups() {
        group.enter()
        let jokesApiCall = URLSession.shared.dataTask(with: URL(string:jokesAddress)!) { d, r, e in
            guard let d = d else {
                return
            }

            guard let response: JokesResponse = try? JSONDecoder().decode(JokesResponse.self, from: d) else {
                return
            }
            self.jokesResponse = response
            self.group.leave()
        }
        
        group.enter()
        let drinksApiCall = URLSession.shared.dataTask(with: URL(string:drinksAddress)!) { d, r, e in
            guard let d = d else {
                return
            }

            guard let response: DrinksResponse = try? JSONDecoder().decode(DrinksResponse.self, from: d) else {
                return
            }
            self.drinksResponse = response
            self.group.leave()
        }
        
        group.enter()
        let musicApiCall = URLSession.shared.dataTask(with: URL(string:musicAddress)!) { d, r, e in
            guard let d = d else {
                return
            }

            guard let response: MusicResponse = try? JSONDecoder().decode(MusicResponse.self, from: d) else {
                return
            }
            self.musicResponse = response
            self.group.leave()
        }

        jokesApiCall.resume()
        drinksApiCall.resume()
        musicApiCall.resume()
      
        group.notify(queue: .main) {
            self.printResponses()
        }
    }
    
    func printResponses() {
        print(jokesResponse!)
        print(drinksResponse!)
        print(musicResponse!)
    }
}
