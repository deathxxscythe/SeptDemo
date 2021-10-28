//
//  DrinkDetailsViewController.swift
//  drinksCache
//
//  Created by Luat on 8/24/21.
//

import UIKit

class DrinkDetailsViewController: UIViewController {

    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    var drinkItem: DrinkItem?
    
    var isFav = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkNameLabel.text = drinkItem?.name
        
        drinkImageView.image = ImageCache.shared.read(imageStr: drinkItem?.imageStr ?? "")
        print("drink details \(drinkItem)")
        addTapToHeartView()
        
    }
    
    func addTapToHeartView() {
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        heartImageView.addGestureRecognizer(tapGest)
        heartImageView.isUserInteractionEnabled = true
    }
    
    @objc func handleTap() {
        print("tapped")
        isFav = !isFav
        
        let imageStr = isFav ? "heart.fill" : "heart"
        heartImageView.image = UIImage(systemName: imageStr)
        
    }
    
}
