//
//  FavGameVM.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation

protocol FavGameVMDelegate {
    func fetched(response : GameModel)
    func gameIdFetched(data: [String]?)
}

class FavGameVM {
    private let api = API()
    private let manager : CoreDataManager = CoreDataManager()
    var delegate : FavGameVMDelegate?
    
    
    
    func getGame() {
        api.fetchGames() { result in
            switch result {
            case.success(let data):
                self.delegate?.fetched(response: data)
                self.getID()
                print("succes: \(data)")
            case .failure(let err):
                print("err getgames: \(err.localizedDescription)")
                
            }
        }
    }
    func getID() {
        let gameId = manager.fetchGameId()
        self.delegate?.gameIdFetched(data: gameId)
    }
}
