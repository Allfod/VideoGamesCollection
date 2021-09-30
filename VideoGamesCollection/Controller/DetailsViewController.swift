//
//  DetailsViewController.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import UIKit
import JGProgressHUD
import Kingfisher
import MotionToastView


class DetailsViewController: UIViewController,Storyboardable {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameOfNameL: UILabel!
    @IBOutlet weak var gameReleasedL: UILabel!
    @IBOutlet weak var gameRatingL: UILabel!
    @IBOutlet weak var gameDescriptionTW: UITextView!
    @IBOutlet weak var favButton: UIButton!
    private let coredata :CoreDataManager = CoreDataManager()
    private let api = API()
    let viewModel = GameDetailVM()
    let hud = JGProgressHUD()
    var gameId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        hud.textLabel.text = "Loading"
        viewModel.getDetail(gameId: gameId!)
        viewModel.checkFavGame(gameId: gameId!)
        hud.dismiss()

     
    }
    @IBAction func likeTap(_ sender: Any) {
        if coredata.createGameıD(gameId: gameId!) {
            favButton.setImage(UIImage.init(named: "star.fill"), for: .normal)
            MotionToast(message: "Fav added.", toastType: .success,toastCornerRadius: 12)
        }else {
            let alert = UIAlertController(title: "Alert", message: "Deleted from your favorites.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert,animated: true,completion: nil)
        }
        
    }
    

  

}
extension DetailsViewController : DetailGameVMDelegate {
    
    
    func fetched(response: GameDetailModel) {
        if let url = URL(string: "\(response.backgroundImage)") {
            gameImageView.kf.setImage(with:url)
        }
        gameOfNameL.text = response.name
        gameRatingL.text = "\(response.metacritic)"
        gameDescriptionTW.text = response.descriptionRaw
        gameReleasedL.text = response.released
    
    }
    func checkFavGame(status: Bool) {
        if status {
            favButton.setImage(UIImage.init(named: "star.fill"), for: .normal)
        }else {
            favButton.setImage(UIImage.init(named: "star"), for: .normal)
        }
    }
}
