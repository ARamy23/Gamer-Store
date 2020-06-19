//
//  GamesSearcher.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

typealias PaginationDetails = (pageSize: Int, page: Int)

final class GamesSearcher {
    
    private let query: String
    private let pagination: PaginationDetails
    private let network: NetworkProtocol
    
    init(query: String, pagination: PaginationDetails, network: NetworkProtocol) {
        self.query = query
        self.network = network
        self.pagination = pagination
    }
    
    func search(_ onFetch: @escaping (((Result<[Game], Error>) -> Void))) {
        network.cancelPreviousTask()
        network.call(GamesService.search(pagination.pageSize, pagination.page, query), GamesFeedResponse.self) { (result) in
            switch result {
            case let .success(feed):
                onFetch(.success(feed.results ?? []))
            case let .failure(error):
                onFetch(.failure(error))
            }
        }
    }
}
