//
//  GameViewModel.swift
//  GamerStore
//
//  Created by Ahmed Ramy on 6/19/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

struct GameViewModel {
    let id: String
    let title: String
    let metacritic: Int
    let genres: String
    let imageURL: String
    
    init(game: Game) {
        self.id = String(game.id ?? 0)
        self.title = game.name ?? ""
        self.metacritic = game.metacritic ?? 0
        self.genres = (game.genres ?? []).map { $0.name ?? "" }.joined(separator: ", ")
        self.imageURL = game.backgroundImage ?? ""
    }
    
    init(game: GameDetailsViewModel) {
        self.id = game.id
        self.title = game.title
        self.metacritic = game.metacritic
        self.genres = game.genres
        self.imageURL = game.imageURL
    }
}
