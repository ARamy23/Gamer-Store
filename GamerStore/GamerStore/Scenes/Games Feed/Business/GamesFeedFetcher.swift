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
    
    init(network: NetworkProtocol, cache: CacheProtocol) {
        self.network = network
        self.cache = cache
    }
    
    private func fetchGamesFeed(_ onFetch: @escaping (([Game]) -> Void)) {
//        GamesFeedRepository(network, cache).fetchGamesFeed(onFetch)
    }
}
