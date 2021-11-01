//
//  Main ViewModel.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/30/21.
//

import Foundation

class MainViewModel {
    var updateShowData: (([Show]) -> Void)?
    var updateCharacterData: (([Character]) -> Void)?
    
    var searchType: String?
    
    var showData: [Show]? {
        didSet{
            updateShowData?(showData!)
        }
    }
    var characterData: [Character]? {
        didSet{
            updateCharacterData?(characterData!)
        }
    }
    
    var url: String?
    
    func setUrl(url: String) {
        self.url = url
    }
    func getUrl() -> String {
        return url!
    }
}
