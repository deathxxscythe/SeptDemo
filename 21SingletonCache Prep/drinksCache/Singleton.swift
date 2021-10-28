//
//  Singleton.swift
//  drinksCache
//
//  Created by Luat on 10/25/21.
//

import UIKit

/// Design Pattern: Singleton
/// Entire app will only have 1 instance of this object
struct Something {
    
    func something() {
//        let myView = UIView()
//        FileManager.default
//        NotificationCenter.default
//        URLSession.shared
//        UserDefaults.standard
//        let firstSingleton = MySingleton()
//        let secondSingleton = MySingleton()
        MySingleton.shared
        MySingleton.shared
        MySingleton.shared
        
    }
}

class MySingleton {
    static let shared = MySingleton()
    private init() {}
    
}
