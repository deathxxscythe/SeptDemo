//
//  DrinksCell.swift
//  week03assessment
//
//  Created by Nathaniel Patterson on 10/18/21.
//

import UIKit

class DrinksCell: UITableViewCell {
    
    static let identifier = "drinksCell"

    static func nib() -> UINib {
        return UINib(nibName: "DrinksCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
