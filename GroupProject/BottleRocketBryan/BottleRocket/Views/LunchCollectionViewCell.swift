//
//  LunchCollectionViewCell.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/21/21.
//

import UIKit

class LunchCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: LunchCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var category: UILabel!
    private var lunchCellVM: LunchCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(lunchCellVM: LunchCellViewModel) {
        self.lunchCellVM = lunchCellVM
        updateUI()
    }
    
    private func updateUI() {
        name.text = lunchCellVM?.name
        category.text = lunchCellVM?.category
        setImage()
    }
    
    private func setImage() {
        let imageStr = lunchCellVM?.url ?? ""
        lunchCellVM?.fetchImage(imageStr: imageStr) { image in
            self.imageView.image = image
        }
    }

}
