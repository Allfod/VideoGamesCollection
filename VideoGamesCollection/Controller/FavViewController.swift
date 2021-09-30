//
//  FavViewController.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import UIKit
import Kingfisher
import JGProgressHUD
class FavViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = FavGameVM()
    let hud = JGProgressHUD()
    var game :GameModel? = nil
    var filtered: [GameResults]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        viewModel.getGame()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getID()
    }
    

    

}
extension FavViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FavCollectionViewCell else { return UICollectionViewCell() }
        if let element = filtered?[indexPath.row] {
            cell.getItem = element
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = DetailsViewController.instantiate()
        viewController.gameId = filtered?[indexPath.row].id
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtered?.count ?? 0
    }
    
    
    
}
extension FavViewController : FavGameVMDelegate {
    func fetched(response: GameModel) {
        game = response
        hud.dismiss()
    }
    func gameIdFetched(data: [String]?) {
        filtered = game?.results.filter({ (game) -> Bool in
            collectionView.reloadData()
            return data?.contains(String(game.id)) ?? false ;
        })
    }
}
