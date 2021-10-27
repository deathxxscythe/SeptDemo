//
//  ViewController.swift
//  week03assessment
//
//  Created by Luat on 10/18/21.
//

import UIKit

class HomeViewController: UIViewController {

    /// Show "setup" and "delivery" fields
    let jokesAddress = "https://v2.jokeapi.dev/joke/Any?type=twopart"
    
    /// Show drink name, drink imageUrl, and drink ID
    let drinksAddress = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Rum"
    
    /// Fetch music if you are done early. Show song and artist name
    let musicAddress = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/songs.json"

    var delegate: Coordinator!
    @IBAction func fetchAll(_ sender: Any) {
        APIGroup().groups()
    }
    
    @IBAction func jokesButton(_ sender: Any) {
        delegate.pushJokesVC()
    }
    @IBAction func drinksButton(_ sender: Any) {
        print("Hello")
        delegate.pushDrinksVC()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
