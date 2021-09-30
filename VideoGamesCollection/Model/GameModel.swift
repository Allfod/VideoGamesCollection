//
//  GameModel.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation
struct GameModel: Codable {
    var results : [GameResults]
    enum CodingKeys : String , CodingKey {
        case results
    }
}

struct GameResults: Codable {
    let id : Int
    let name,released : String
    let backgroundImage : String
    let metacritic : Int
    enum CodingKeys : String,CodingKey {
        case id , name , released
        case backgroundImage = "background_image"
        case metacritic
    }
}


