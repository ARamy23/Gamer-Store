//
//  GamesFeedRepository.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class GamesFeedRepository {
    private let network: NetworkProtocol
    private let cache: CacheProtocol
    private let pagination: PaginationDetails
    
    init(pagination: PaginationDetails, network: NetworkProtocol, cache: CacheProtocol) {
        self.pagination = pagination
        self.network = network
        self.cache = cache
    }
    
    func fetchGamesFeed(isRefreshing: Bool, _ onFetch: @escaping ((Result<[Game], Error>) -> Void)) {
        
        if !isRefreshing, let games = cache.getObject([Game].self, key: .gamesFeed) {
            onFetch(.success(games))
        }
        
        network.call(GamesService.gamesFeed(pagination.pageSize, pagination.page), GamesFeedResponse.self) { (result) in
            switch result {
            case .success(let response):
                guard let games = response.results else {
                    onFetch(.failure(NetworkError.somethingWentWrong))
                    return
                }
                self.cache.saveObject(games, key: .gamesFeed)
                onFetch(.success(games))
            case let .failure(error):
                onFetch(.failure(error))
            }
        }
    }
}
