//
//  MainCollectionViewCell.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameOfNameL: UILabel!
    @IBOutlet weak var gameOfRatingL: UILabel!
    @IBOutlet weak var gameOfReleasedL: UILabel!
    
    
    var getItem: GameResults! {
        didSet {
            if let url = URL(string: "\(getItem.backgroundImage)") {
                gameImageView.kf.setImage(with: url) }
            gameOfNameL.text = getItem.name
            gameOfRatingL.text = "\(getItem.metacritic)"
            gameOfReleasedL.text = getItem.released
            self.clipsToBounds = false
            
            }
        }
    }

