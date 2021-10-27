//
//  Coordinator.swift
//  week03assessment
//
//  Created by Luat on 10/18/21.
//

import UIKit

class Coordinator {
    var navCon = UINavigationController()
    
    /// This func is not complete
    func pushHomeVC() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let homeVC = sb.instantiateViewController(identifier: "HomeVC") as? HomeViewController {
            homeVC.delegate = self
            navCon.pushViewController(homeVC, animated: true)
        }
        
    }
    
    func pushJokesVC() {
        let sb = UIStoryboard(name: "JokesViewController", bundle: nil)
        if let jokesVC = sb.instantiateViewController(withIdentifier: "jokesVC") as? JokesViewController {
            jokesVC.coordinator = self
            navCon.pushViewController(jokesVC, animated: true)
        }
    }
    
    func pushDrinksVC() {
        let sb = UIStoryboard(name: "DrinksViewController", bundle: nil)
        if let drinksVC = sb.instantiateViewController(withIdentifier: "drinksVC") as? DrinksViewController {
            drinksVC.coordinator = self
            navCon.pushViewController(drinksVC, animated: true)
        }
    }
}
