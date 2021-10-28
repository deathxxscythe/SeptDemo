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
        count += 1
    }
    
    var onReuse: () -> Void = { [count] in
        print("reusing cell #: \(count)")
    }
    
    /// 1. Before we reuse cell,
    /// - clear the previous image
    /// - cancel all previous running tasks
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        drinkImageView.image = nil
    }
}
var count = 0
