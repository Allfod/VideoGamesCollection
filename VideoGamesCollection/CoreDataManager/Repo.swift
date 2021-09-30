//
//  Repo.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation
protocol Repo {
    func create(gameId:Int)->Bool
    func getAll() -> [String]?
    func delete(id:Int)-> Bool
    func checkGame (byid id:Int)-> Bool
}
