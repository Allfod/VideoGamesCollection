//
//  Store.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation
import CoreData
final class Storage {
    
    private init() {}
    lazy var context = persistantContainer.viewContext
    static let shared = Storage()
    
    lazy var persistantContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VideoGamesCollection")
        
        container.loadPersistentStores(completionHandler: {(storeDescription , error ) in
            if let error = error as NSError?{
                fatalError("Unsolved error \(error), \(error.userInfo)")
            }
            })
        return container
        }()
    
    func saveStaffs () {
        let staff = persistantContainer.viewContext
        if staff.hasChanges {
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("Unsolved error\(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    func fetchObject <T:NSManagedObject>(managedObject: T.Type)-> [T]? {
        do {
            guard let result = try Storage.shared.context.fetch(CDGames.fetchRequest()) as? [T] else {    return nil}
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
