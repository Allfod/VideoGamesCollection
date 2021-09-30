//
//  Manager.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation
import Moya


class API {

    var provider = MoyaProvider<Request>(plugins: [NetworkLoggerPlugin()])

    func fetchGames(completion: @escaping (Result<GameModel, Error>) -> ()) {
        request(target: .getGame, completion: completion)
    }
    func fetchGameDetails(id: Int, completion: @escaping (Result<GameDetailModel, Error>) -> ()) {
        request(target: .getGameDetail(id: id), completion: completion)
    }

    func request<T: Decodable>(target: Request, completion: @escaping(Result<T, Error>) -> ()) {

        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
