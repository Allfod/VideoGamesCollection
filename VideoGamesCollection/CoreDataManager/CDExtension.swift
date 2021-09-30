//
//  CDExtension.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 30.09.2021.
//

import Foundation
import CoreData

extension CDGames {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGames> {
        return NSFetchRequest<CDGames>(entityName: "GamesCD")
    }

    @NSManaged  var game_id: String?

}
extension CDGames : Identifiable{

}
