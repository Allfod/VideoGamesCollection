//
//  GameDetail.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation

struct GameDetailModel: Codable {
    let id: Int
    let name: String
    let descriptionRaw: String
    let metacritic: Int
    let released: String
    let backgroundImage: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case descriptionRaw = "description_raw"
        case metacritic
        case released
        case backgroundImage = "background_image"
    }
}
