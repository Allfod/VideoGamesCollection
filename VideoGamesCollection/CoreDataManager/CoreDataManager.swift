//
//  CoreDataManager.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation
struct CoreDataManager  {
    private let _coreDataRepo = CoreDataRepo()
    
    func createGameıD(gameId: Int) -> Bool {
        return _coreDataRepo.create(gameId: gameId)
    }
    func fetchGameId() -> [String]? {
        return _coreDataRepo.getAll()
    }
    func deleteGame(id:Int) -> Bool {
        return _coreDataRepo.delete(id: id)
    }
    func checkGame(byId id: Int) -> Bool {
        return _coreDataRepo.checkGame(byid: id)
    }
}
