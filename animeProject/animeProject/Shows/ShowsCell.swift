//
//  ShowsCell.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/31/21.
//

import UIKit

class ShowsCell: UITableViewCell {

    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var episodeCount: UILabel!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(title: String, episodes: Int, description: String) {
        showTitle.text = title
        episodeCount.text = "Episode: \(String(episodes))"
        showDescription.text = description
    }
    
    var onReuse: () -> Void = {}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        showImage.image = nil
    }
    
}
