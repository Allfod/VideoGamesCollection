//
//  Request.swift
//  VideoGamesCollection
//
//  Created by Vural ÇETİN on 28.09.2021.
//

import Foundation
import Moya

enum APICons {
    public static let baseUrl = "https://api.rawg.io/api"
    public static let apiKey = "4e8ed7573c3a45ac8c59a067c5f6fd0a"
}

enum Request {
    case getGame
    case getGameDetail(id: Int)
}

extension Request: TargetType {
    var path: String {
        switch self {
        case.getGame:
            return "games"
        case.getGameDetail(let id):
            return "games/\(id)" // buraya bak
         }
    }
    
    var method: Moya.Method {
        return.get
    }
    
    var task: Task {
        switch self {
        case.getGame:
            let parameter = ["key":APICons.apiKey] as [String:Any]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case .getGameDetail:
            let parameter = ["key":APICons.apiKey] as [String:Any]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        }
    
    
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        guard let url = URL(string: APICons.baseUrl) else {fatalError()}
        return url
    }
    
    
}

