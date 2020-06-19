//
//  GamesFeedFetcher.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class GamesFeedFetcher {
    private let network: NetworkProtocol
    private let cache: CacheProtocol
    private let pagination: PaginationDetails
    
    init(pagination: PaginationDetails, network: NetworkProtocol, cache: CacheProtocol) {
        self.network = network
        self.cache = cache
        self.pagination = pagination
    }
    
    func fetchGamesFeed(_ onFetch: @escaping ((Result<[Game], Error>) -> Void)) {
        GamesFeedRepository(pagination: pagination, network: network, cache: cache)
            .fetchGamesFeed(isRefreshing: false, onFetch)
    }
    
    func refreshGamesFeed(_ onFetch: @escaping ((Result<[Game], Error>) -> Void)) {
        GamesFeedRepository(pagination: pagination, network: network, cache: cache)
            .fetchGamesFeed(isRefreshing: true, onFetch)
    }
}
