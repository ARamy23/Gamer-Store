//
//  GameDetailsFetcher.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/20/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

final class GameDetailsFetcher {
    private let gameID: String
    private let network: NetworkProtocol
    
    init(gameID: String, network: NetworkProtocol) {
        self.gameID = gameID
        self.network = network
    }
    
    func fetchGameDetails(_ onFetch: @escaping ((Result<GameDetails, Error>) -> Void)) {
        network.call(GamesService.gameDetails(gameID), GameDetails.self, onComplete: onFetch)
    }
}
