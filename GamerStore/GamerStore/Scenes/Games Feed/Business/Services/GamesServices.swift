//
//  GamesServices.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

enum GamesService {
    case gamesFeed(_ pageSize: Int, _ page: Int)
    case search(_ pageSize: Int, _ page: Int, _ query: String)
    case gameDetails(_ id: String)
}

extension GamesService: Endpoint {
    var path: String {
        switch self {
        case .gamesFeed, .search:
            return "games"
        case let .gameDetails(id):
            return "games/\(id)"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .gamesFeed(pageSize, page):
            return ["page_size": String(pageSize), "page": String(page)]
        case .gameDetails:
            return [:]
        case let .search(pageSize, page, query):
            return ["page_size": String(pageSize), "page": String(page), "search": query]
        }
    }
    
    var encoding: ParametersEncoding {
        switch self {
        case .gamesFeed, .gameDetails, .search:
            return .urlEncoding
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .gamesFeed, .gameDetails, .search:
            return .GET
        }
    }
    
    
}
