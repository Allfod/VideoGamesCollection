//
//  GameVM.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation
protocol GamesVMDelegate {
    func fetched(response : GameModel)
}

class GameVM {
    private let api = API()
    var delegate : GamesVMDelegate?
    func getGame() {
        api.fetchGames() { (result) in
            switch result {
            case .success(let data) :
                self.delegate?.fetched(response: data)
                print("succes: \(data)")
            case .failure(let error):
                print("error getGame: \(error.localizedDescription)")
            }
        }
    }
}
