//
//  DrinkCell.swift
//  drinksCache
//
//  Created by Luat on 8/23/21.
//

import UIKit

class DrinkCell: UITableViewCell {

    static let identifier = String(describing: DrinkCell.self)
    
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkDesc: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drinkName.text = "test name"
        drinkDesc.text = "test desc"
    }
    
}
