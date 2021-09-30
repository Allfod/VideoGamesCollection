//
//  CoreDataRepo.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation
import CoreData

struct CoreDataRepo: Repo {
    
    
    func create(gameId: Int) -> Bool {
        if !checkGame(byid: gameId) {
            let gameID = CDGames(context:Storage.shared.context )
            gameID.game_id = String(gameId)
            Storage.shared.saveStaffs()
            return true
        }
        return false
    }
    
    func getAll() -> [String]? {
        var gameId:[String] = []
        let fetchRequest = NSFetchRequest<CDGames>(entityName: "GamesCD")
        do {
            let result = try Storage.shared.context.fetch(fetchRequest)
            
            for staff in result as [NSManagedObject] {
                if let selectData = (staff.value(forKey: "game_id")!) as? String {
                    gameId.append(selectData)
                }
            }
        } catch let err as NSError {
            print("Fetch not complete.\(err),\(err.userInfo) ")
        }
        return gameId
    }
    func delete(id: Int) -> Bool {
        let getCDID = getCDID(byId: id)
        guard getCDID != nil else { return false }
        Storage.shared.context.delete(getCDID!)
        Storage.shared.saveStaffs()
        return true
    
    }
     func checkGame(byid id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<CDGames>(entityName: "GamesCD")
        let predicate = NSPredicate(format:"game_id==%@" , String(id) as CVarArg)
        
        fetchRequest.predicate = predicate
        do {
            let result = try Storage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return false }
            return true
        } catch let err{
            
            debugPrint(err)
        }
        return false
    }
    private func getCDID(byId id: Int) -> CDGames? {
        let fetchRequest = NSFetchRequest<CDGames>(entityName: "GamesCD")
        let predicate = NSPredicate(format: "game_id==%@", String(id) as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try Storage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil}
            return result
        } catch let err {
            debugPrint(err)
        }
        return nil
    }
}
