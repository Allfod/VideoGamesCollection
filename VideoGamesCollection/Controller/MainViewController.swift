//
//  MainViewController.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import UIKit
import Kingfisher
import JGProgressHUD

class MainViewController: UIViewController , Storyboardable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slidePageControl: UIPageControl!
    @IBOutlet weak var sliderStackView: UIStackView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var collectionViewConstraint: NSLayoutConstraint!
    private let api = API()
    private let hud = JGProgressHUD()
    let viewModel = GameVM()
    var game : GameModel? = nil
    var dropGames : [GameResults]?
    var slideGame : [GameResults]?
    var search : [GameResults]?
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count - 1 ] as? URL)
       
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        searchBar.delegate = self
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        viewModel.getGame()
        let swipeLeftGesturRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SwipeLeft))
        slideImageView.isUserInteractionEnabled = true
        swipeLeftGesturRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        slideImageView.addGestureRecognizer(swipeLeftGesturRecognizer)
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SwipeRight))
        slideImageView.isUserInteractionEnabled = true
        swipeRightGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.right
        slideImageView.addGestureRecognizer(swipeRightGestureRecognizer)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTap(tapgestureRecognizer:)))
        slideImageView.addGestureRecognizer(tapGestureRecognizer)

        
    }
    @objc func SwipeLeft () {
    slidePageControl.currentPage += 1
    setSlideImages()
    }
    @objc func SwipeRight () {
        slidePageControl.currentPage -= 1
        setSlideImages()
    }
    @objc func imageTap(tapgestureRecognizer : UITapGestureRecognizer) {
        let viewController = DetailsViewController.instantiate()
        viewController.gameId = slideGame?[slidePageControl.currentPage].id
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setSlideImages () {
        switch slidePageControl.currentPage {
        case 0 :
            if let url = URL(string: "\(slideGame?[slidePageControl.currentPage].backgroundImage ?? "")") {
                slideImageView.kf.setImage(with : url)
            }
            UIView.transition(with: slideImageView, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        case 1 :
            if let url = URL(string: "\(slideGame?[slidePageControl.currentPage].backgroundImage ?? "")") {
            slideImageView.kf.setImage(with : url)
        }
            UIView.transition(with: slideImageView, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        case 2 :
            if let url = URL(string: "\(slideGame?[slidePageControl.currentPage].backgroundImage ?? "")") {
            slideImageView.kf.setImage(with : url)
        }
            UIView.transition(with: slideImageView, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        default :
            slidePageControl.currentPage = 0

        }
    }
    
}

extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        if searching {
            if let element = search?[indexPath.row] {
                cell.getItem = element            }
        }else {
            if let element = dropGames?[indexPath.row] {
                cell.getItem = element
            }
        }
    return cell
   }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return search?.count ?? 0
        }else {
            return dropGames?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = DetailsViewController.instantiate()
        if searching {
            viewController.gameId = search?[indexPath.row].id
            
        }else {
            viewController.gameId = dropGames?[indexPath.row].id
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            search = game?.results.filter({ data -> Bool in
                let searchLower = searchText.lowercased()
                let match : [String?] = [data.name]
                let nonilElement = match.compactMap{$0 }
                for element in nonilElement {
                    if element.lowercased().contains(searchLower) {
                        return true
                    }
                }
                return false
            }) ?? []
            if search!.count == 0 {
                noDataLabel.isHidden = false
                collectionView.isHidden = true
            }
            searching = true
            sliderStackView.isHidden = true
            collectionViewConstraint.constant = 0
            collectionView.reloadData()
            self.hud.dismiss()
        }
        if searchText.count < 1 {
            searching = false
            sliderStackView.isHidden = false
            noDataLabel.isHidden = true
            collectionView.isHidden = false
            collectionViewConstraint.constant = 250
            collectionView.reloadData()
            
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
}
extension MainViewController : GamesVMDelegate {
    func fetched(response: GameModel) {
        game = response
        let array = response.results[0..<3]
        slideGame = Array(array)
        
        if let dropGame = game?.results.dropFirst(3) {
            dropGames = Array(dropGame)
        }
        if let url = URL(string: "\(slideGame?[slidePageControl.currentPage].backgroundImage ?? "")") {
            slideImageView.kf.setImage(with: url)
        }
        collectionView.reloadData()
        hud.dismiss()
       
}
}
