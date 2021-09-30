//
//  DetailGameVM.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation

protocol DetailGameVMDelegate {
    func fetched(response : GameDetailModel)
    func checkFavGame(status: Bool)
}
class GameDetailVM {
    private let api = API()
    private let manager : CoreDataManager = CoreDataManager()
    var delegate : DetailGameVMDelegate?
    func getDetail(gameId: Int) {
        api.fetchGameDetails(id: gameId) { result in
            switch result {
            case .success(let data ) :
                self.delegate?.fetched(response: data)
                print("succes : \(data)  ")
            case.failure(let err ):
                print("Error \(err.localizedDescription)")
            }
        }
    }
    func checkFavGame(gameId: Int ) {
        if manager.checkGame(byId: gameId){
            self.delegate?.checkFavGame(status: true)
        }else {
            self.delegate?.checkFavGame(status: false)
        }
    }
    
    func deleteFav(gameId: Int) {
        if manager.deleteGame(id: gameId) {
            checkFavGame(gameId: gameId)
        }
    }
}
