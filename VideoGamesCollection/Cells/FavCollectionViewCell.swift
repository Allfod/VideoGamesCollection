//
//  FavCollectionViewCell.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import UIKit
import Kingfisher

class FavCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favGameImageView: UIImageView!
    @IBOutlet weak var favGameOfNameL: UILabel!
    @IBOutlet weak var favGameRatingL: UILabel!
    @IBOutlet weak var favGameReleasedL: UILabel!
    
    var getItem : GameResults! {
        didSet {
            if let url = URL(string: "\(getItem.backgroundImage)") {
                favGameImageView.kf.setImage(with:url)
            }
            favGameOfNameL.text = getItem.name
            favGameRatingL.text = "\(getItem.metacritic)"
            favGameReleasedL.text = getItem.released
            
        }
    }
    
}
